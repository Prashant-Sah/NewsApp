//
//  AppCoordinator.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine

final class AppCoordinator: BaseCoordinator {

    /// The main route for the app
    private let route: Route

    /// Initializer
    init(route: Route) {
        self.route = route
        super.init()
    }

    /// Start the coordinator process
    override func start() {
        showArticleList()
    }

    /// runs dashboard coordinator
    private func showArticleList() {

        let viewModel = ArticleListViewModel(newsManager: NewsManager())

        let articleList = ArticleListController(baseView: ArticleListView(), baseViewModel: viewModel)

        viewModel.trigger.receive(on: RunLoop.main).sink { [weak self] (route) in
            guard let self = self else { return }
            self.handleRedirection(route)
        }.store(in: &viewModel.bag)

        // set tab bar controller as root to route
        route.setRoot(articleList, animated: true, hideBar: false)
    }

    private func showDetailView(with article: Article) {
        let detailController = ArticleDetailController(baseView: ArticleDetailView(), baseViewModel: ArticleDetailViewModel(article: article))
        route.push(detailController)
    }

    /// handles redirection with route provided
    /// - Parameter route: AppRoutable
    private func handleRedirection(_ route: AppRoutable) {
        switch route {
        case AppRoute.detail(let article):
            self.showDetailView(with: article)
        default: assertionFailure("route not handled")
        }
    }
}
