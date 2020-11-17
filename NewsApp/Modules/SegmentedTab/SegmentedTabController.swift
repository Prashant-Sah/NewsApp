//
//  SegmentedTabController.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine
import UIKit

/// The main segment controller to display the segments tab
class SegmentTabController: BaseController {

    /// The view of the segmented tab
    lazy var screenView: SegmentTabView = {
        return self.baseView as! SegmentTabView //swiftlint:disable:this force_cast
    }()

    /// The viewmodel to manage the data for this class
    lazy var viewModel: SegmentTabViewModel = {
        return self.baseViewModel as! SegmentTabViewModel //swiftlint:disable:this force_cast
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        /// Set the segements
        screenView.setSegments(segmentManageables: viewModel.pageController.segmentManageable)

        /// add the page to conatiner
        viewModel.pageController.view.frame = screenView.pageHolder.frame
        screenView.pageHolder.addSubview(viewModel.pageController.view)
        addChild(viewModel.pageController)
        viewModel.pageController.didMove(toParent: self)

        // set initial selection
        setSelectionIndex(index: viewModel.initialIndexToSelect)
    }

    override func observeEvents() {

        /// Whenever a segment is selected
        screenView.selectedSegment.receive(on: RunLoop.main).sink { [weak self](index) in
            guard let self = self else { return }
            self.viewModel.pageController.show(atIndex: index, animated: true)
        }.store(in: &viewModel.bag)

        /// Whenever a page is changed by gesture
        viewModel.pageController.currentIndex.receive(on: RunLoop.main).sink { [weak self] (index) in
            guard let self = self else { return }
            self.screenView.setSelected(index)
        }.store(in: &viewModel.bag)
    }

    /// set selection with index path
    /// - Parameter index: index
    func setSelectionIndex(index: Int) {
        viewModel.pageController.show(atIndex: index, animated: false)
        screenView.setSelected(index)
    }
}
