//
//  ArticleListController.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine
import UIKit

class ArticleListController: BaseController {

    var screenView: ArticleListView {
        baseView as! ArticleListView
    }

    var viewModel: ArticleListViewModel {
        baseViewModel as!  ArticleListViewModel
    }

    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNewsHeadLines()
        screenView.indicate = true
    }

    override func setupUI() {
        title = "Top Headlines"
        screenView.tableView.dataSource = self
        screenView.tableView.delegate = self
        screenView.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc func refreshData() {
        self.viewModel.getNewsHeadLines(reload: true)
    }

    override func observeEvents() {
        viewModel.newsManager.articles.dropFirst().receive(on: RunLoop.main).sink { [weak self] (articles) in
            guard let self = self else { return }
            self.screenView.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.screenView.indicate = false
        }.store(in: &viewModel.bag)

        viewModel.newsManager.error.receive(on: RunLoop.main).sink { [weak self] (message) in
            guard let self = self else { return }
            self.alert(title: "Error", msg: message, actions: [.ok])
        }.store(in: &viewModel.bag)

    }
}

extension ArticleListController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsManager.articles.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(ArticleCell.self, for: indexPath)
        cell.article = viewModel.newsManager.articles.value[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.newsManager.articles.value[indexPath.row]
        viewModel.trigger.send(AppRoute.detail(article))
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentOffset = tableView.contentOffset.y
        let maximumOffset = tableView.contentSize.height - tableView.frame.size.height

        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 10.0 {
            self.viewModel.getNewsHeadLines()
        }
    }
}
