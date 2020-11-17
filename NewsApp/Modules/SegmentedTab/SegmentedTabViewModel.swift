//
//  SegmentedTabViewModel.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation

class SegmentTabViewModel: BaseViewModel {

    /// The page controller that will go inside the container
    let pageController: PageControllerIndexable

    /// initial index to select
    let initialIndexToSelect: Int

    /// Initializer
    init(pageController: PageControllerIndexable, initialIndexToSelect: Int = 0) {
        self.initialIndexToSelect = initialIndexToSelect
        self.pageController = pageController
    }
}
