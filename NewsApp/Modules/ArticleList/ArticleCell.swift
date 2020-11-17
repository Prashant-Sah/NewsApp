//
//  ArticleCell.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import UIKit

class ArticleCell:UITableViewCell {

    lazy var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var article: Article! {
        didSet {
            configureCell()
        }
    }

    var openArticle: ((Article) -> ())?

    private func  addSubViews()  {

        contentView.backgroundColor = .clear
        contentView.addSubview(articleImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(separator)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descLabel)

        /// contraint image
        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),

            articleImageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            articleImageView.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 15),
            articleImageView.widthAnchor.constraint(equalToConstant: 120),
            articleImageView.heightAnchor.constraint(equalToConstant: 100),
            articleImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -25),

            sourceLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 0),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            sourceLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0),

            separator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            separator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ])

    }

    private func configureCell() {
        selectionStyle = .none
        titleLabel.text = article.title ?? ""
        descLabel.text = article.content ?? ""
        sourceLabel.text = article.source?.name ?? ""
        articleImageView.setImageWithUrlString(string: article.urlToImage ?? "")
    }

    @objc private func actionButton() {
        openArticle?(article)
    }
}
