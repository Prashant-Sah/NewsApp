//
//  ArticleDetailView.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/17/20.
//

import Foundation
import UIKit
import WebKit

class ArticleDetailView: BaseView {

    lazy var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func create() {
        super.create()

        addSubview(webView)
        ///  constraint button
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}
