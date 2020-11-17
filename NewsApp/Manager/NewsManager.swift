//
//  NewsManager.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/12/20.
//

import Foundation
import Combine

class NewsManager {

    var bag = Set<AnyCancellable>()

    var articles = CurrentValueSubject<[Article], Never>([])

    let isApicall = CurrentValueSubject<Bool, Never>(false)

    let networking = Networking()

    var page: Pagination = Pagination()

    var error = PassthroughSubject<String, Never>()

    let elementsPerPage = 20

    func fetchHeadLines(isReload: Bool) {
        if isReload {
            page = Pagination()
            self.isApicall.send(false)
        }
        guard !isApicall.value && page.hasNextPage else { return }
        var params: [String: Any] = ["country": "US"]
        params ["page"] = page.page + 1
        isApicall.send(true)
        let router = NewsRouter.headline(params)
        networking.request(router: router).sink { [weak self] result in
            guard let self = self else {  return }
            self.isApicall.send(false)
            self.parseResult(result: result, router: router)
        }.store(in: &bag)
    }


    private func parseResult(result: NetworkingResult, router: NetworkingRouter)  {
        switch router {
        case NewsRouter.headline:
            if result.success {
                if let data = result.result as? Data,
                   let result = try? ArticleList.init(data: data),
                   let articlesFromAPI = result.articles {
                    if page.page == 0 {
                        self.articles.send(articlesFromAPI)
                    } else {
                        var articles = self.articles.value
                        articles.append(contentsOf: articlesFromAPI)
                        self.articles.send(articles)
                    }

                    self.updatePageInfo(with: result.totalResults)
                }
            } else {
                let errorMsg = result.error.description
                self.error.send(errorMsg)
            }
        default:
            break
        }

    }

    func updatePageInfo(with total: Int) {
        let currentCount = self.articles.value.count
        let currentPage = Int(Double(currentCount)/Double(elementsPerPage))
        self.page.page = currentPage
        self.page.hasNextPage = total > self.articles.value.count
    }
}

public extension Decodable {
    init(data: Data) throws {
        do {
            self = try JSONDecoder().decode(Self.self, from: data)
        } catch {
            if let decodingError = error as? DecodingError {
                print(decodingError)
            } else {
                print(error.localizedDescription)
            }
            throw error
        }
    }
}
