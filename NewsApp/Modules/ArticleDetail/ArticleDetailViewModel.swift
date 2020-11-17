//
//  ArticleDetailViewModel.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/17/20.
//

import Foundation

class ArticleDetailViewModel: BaseViewModel {

    let article: Article

    init(article: Article) {
        self.article = article
    }
}
