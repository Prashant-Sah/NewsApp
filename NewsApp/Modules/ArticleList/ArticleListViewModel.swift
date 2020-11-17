//
//  ArticleListViewModel.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine

class ArticleListViewModel: BaseViewModel {

    let newsManager: NewsManager

    init(newsManager: NewsManager) {
        self.newsManager = newsManager
        super.init()
      //  getNewsHeadLines()
    }

    func getNewsHeadLines(reload: Bool = false) {
        newsManager.fetchHeadLines(isReload: reload)
    }

}
