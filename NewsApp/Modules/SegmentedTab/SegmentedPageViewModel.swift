//
//  SegmentedPageViewModel.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import UIKit

struct SegmentModel: SegmentManageable {
    var attributedTitle: NSAttributedString
}

final class SegmentedPageViewModel: BaseViewModel {

    /// The pages that will be displayed
    let pages: [BaseController]

    /// Segment model to just display the attributed title
    var manageableSegments = [SegmentModel]()

    /// Initializer
    init(pages: [BaseController]) {
        self.pages = pages
        super.init()
        generateSegmentObject()
    }

    /// Method to create the segment model that will set the title from UIViewController title
    private func generateSegmentObject() {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white,
                                                         .font: UIFont.systemFont(ofSize: 15.0)]
        manageableSegments = pages.map { SegmentModel(attributedTitle: NSAttributedString(string: ($0.title ?? ""), attributes: attributes))}
    }
}
