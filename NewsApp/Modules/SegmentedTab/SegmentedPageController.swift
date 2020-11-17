//
//  SegmentedPageController.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine
import UIKit

class SegmentPageController: UIPageViewController, PageControllerIndexable {

    /// The current selected page index
    var currentIndex = CurrentValueSubject<Int, Never>(0)

    /// The list of segmenet controllers
    var segmentManageable: [SegmentManageable] {  viewModel.manageableSegments }

    /// temporarily holds the next moving index
    private var temporaryTransitionIndex = 0

    /// The viewModel
    private let viewModel: SegmentedPageViewModel

    /// Initializer
    init(segmentedViewModel: SegmentedPageViewModel) {
        self.viewModel = segmentedViewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the delegate and dataSource to self for the controllers
        delegate = self
        dataSource = self

        // Set the initial display controller
        setViewControllers([viewModel.pages[currentIndex.value]], direction: .forward, animated: false, completion: nil)
    }

    /// Method to trigger the page transitions to selected index
    /// - Parameter index: the selected index from segement
    func show(atIndex index: Int, animated: Bool = true) {
        guard index != currentIndex.value else { return }
        let direction: UIPageViewController.NavigationDirection = index < currentIndex.value ? .reverse : .forward
        setViewControllers([viewModel.pages[index]], direction: direction, animated: animated, completion: nil)
        currentIndex.send(index)
    }
}

extension SegmentPageController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? BaseController else { return nil }
        guard let index = viewModel.pages.firstIndex(of: controller) else { return nil }
        switch index {
        case 0:
            return nil
        default:
            return viewModel.pages[index - 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let controller = viewController as? BaseController else { return nil }
        guard let index = viewModel.pages.firstIndex(of: controller) else { return nil }
        switch index {
        case viewModel.pages.count - 1:
            return nil
        default:
            return viewModel.pages[index + 1]
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        guard let controller = pendingViewControllers.first as? BaseController else { return }
        guard let index = viewModel.pages.firstIndex(of: controller) else { return }
        temporaryTransitionIndex = index
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex.send(temporaryTransitionIndex)
        }
    }
}
