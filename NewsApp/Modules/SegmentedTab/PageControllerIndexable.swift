//
//  PageControllerIndexable.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine
import UIKit

/// A protocol for the UIPageViewController to expose their index and number of pages
protocol PageControllerIndexable where Self: UIPageViewController {

    /// Variable to hold the current index of the page
    var currentIndex: CurrentValueSubject<Int, Never> { get }

    /// The segment object that will display the attributed title
    var segmentManageable: [SegmentManageable] { get }

    /// The trigger function called when a external button tries to set the page
    /// - Parameter index: the index of the page (segment)
    /// - Parameter animated: animates the transition of page
    func show(atIndex index: Int, animated: Bool)
}
