//
//  ArticleDetailController.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/17/20.
//

import Foundation
import WebKit

class ArticleDetailController: BaseController {

    var screenView: ArticleDetailView {
        baseView as! ArticleDetailView
    }

    var viewModel: ArticleDetailViewModel {
        baseViewModel as! ArticleDetailViewModel
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    override func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
        title = "Article Detail"
        screenView.webView.navigationDelegate = self
    }

    private func loadData() {
        if let url = URL(string: viewModel.article.url ?? "") {
            screenView.webView.load(URLRequest(url: url))
        } else {
            alert(title: "Error", msg: "Invalid url.", actions: [.ok]) { (_) in
                self.back()
            }
        }
    }
}

extension ArticleDetailController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        screenView.indicate = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        screenView.indicate = false
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        screenView.indicate = false
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        screenView.indicate = false
        alert(title: "Error", msg: error.localizedDescription, actions: [.ok]) { (_) in
            self.back()
        }
    }
}
