//
//  Segment.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import UIKit

/// Protocol acting as the dataSource to get the title of the button
protocol SegmentManageable {
    var attributedTitle: NSAttributedString { get }
}

class Segment: BaseView {

    /// The button for the segment
    lazy var segmentButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var isActive: Bool = false {
        didSet {
            var attributes = [NSMutableAttributedString.Key: Any]()
            if isActive {
                attributes[.foregroundColor] = UIColor.white
            } else {
                attributes[.foregroundColor] = UIColor.white.withAlphaComponent(0.5)
            }
            guard let attributedTitle = segmentButton.currentAttributedTitle else { return }
            let mutableAttribute = NSMutableAttributedString(attributedString: attributedTitle)
            mutableAttribute.addAttributes(attributes, range: NSRange(location: 0, length: attributedTitle.string.count))
            segmentButton.setAttributedTitle(mutableAttribute, for: .normal)
        }
    }

    override func create() {
        generateChildrens()
    }
}

extension Segment {

    private func generateChildrens() {
        addSubview(segmentButton)

        NSLayoutConstraint.activate([
            segmentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            segmentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            segmentButton.topAnchor.constraint(equalTo: topAnchor),
            segmentButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
