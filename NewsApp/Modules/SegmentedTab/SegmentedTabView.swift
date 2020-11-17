//
//  SegmentedTabView.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine
import UIKit

class SegmentTabView: BaseView {

    /// The segments that are calculated
    private var segments = [Segment]()

    /// The segment holder height constraint to increase the height if necessary
    private var segmentHolderHeightConstraint: NSLayoutConstraint!

    /// internal constant helper for button tag
    private let tagValue = 100

    /// The padding in the segments
    private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    /// Trigger for selected segments
    let selectedSegment = PassthroughSubject<Int, Never>()

    /// The scrollView for segments
    lazy var segmentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return scrollView
    }()

    lazy var segmentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        return stackView
    }()

    /// The scrollViews content view
    lazy var segmentContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// The segment holder view
    lazy var segmentHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    /// The page holder container view
    lazy var pageHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    /// The animating legend view
    lazy var legend: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    /// override the create super method
    override func create() {
        self.generateChildrens()
    }

    /// Method to set the segments to be displayed
    /// - Parameters:
    ///   - segmentManageables: the array of segment manageable to get the number of segmenets
    ///   - height: the height of the segment holder
    ///   - padding: the padding for segments
    func setSegments(segmentManageables: [SegmentManageable], height: CGFloat = 44.0, padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1.5, right: 0)) {

        // set the height of the holder
        self.segmentHolderHeightConstraint.constant = height

        /// set the padding
        self.padding = padding

        /// create the segments
        for (index, manageable) in segmentManageables.enumerated() {
            let segment = Segment()
            segment.segmentButton.tag = tagValue + index
            segment.segmentButton.addTarget(self, action: #selector(segmentButtonDidClick(_:)), for: .touchUpInside)
            segment.segmentButton.setAttributedTitle(manageable.attributedTitle, for: .normal)
            segment.backgroundColor = .clear
            segmentStackView.addArrangedSubview(segment)
            segments.append(segment)
        }

        /// add the legend which we will show when frame is obtained
        segmentContentView.addSubview(legend)
    }

    /// Method to set the selected segmenet, This method will animate the legend view
    /// - Parameter index: the index to animate to
    func setSelected(_ index: Int) {
        segments.forEach { $0.isActive = false }
        let segment = segments[index]
        self.scrollIfRequired(segment: segment)
        segment.isActive = true
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: { [unowned self] in
            self.legend.frame.origin.x = segment.frame.origin.x
            self.legend.frame.size.width = segment.frame.size.width
        }, completion: nil)
    }

    /// Method to scroll the scroll view so that the selected segment is always the visible one
    /// - Parameter segment: the segment to scroll to
    private func scrollIfRequired( segment: Segment) {

        /// get the segment offset that we have to move
        let segmentOffset = segmentScrollView.bounds.width / 2.0 - segment.bounds.width / 2.0

        /// Now create the visible position of the segment
        var visibleRect = segment.frame

        /// Change the position of rect by the offset moved
        visibleRect.origin.x -= segmentOffset
        visibleRect.size.width += segmentOffset * 2

        /// Let the scrollView scroll to visible rect
        segmentScrollView.scrollRectToVisible(visibleRect, animated: true)
    }

    /// private method to detect the segmenet button trigger
    @objc private func segmentButtonDidClick(_ sender: UIButton) {
        let tag = sender.tag - tagValue
        selectedSegment.send(tag)
        setSelected(tag)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        /// set the legend frame
        guard let oneOfTheSegment = segments.first else { return }
        legend.frame = CGRect(x: 0, y: segmentHolder.bounds.height - padding.bottom * 2, width: oneOfTheSegment.frame.size.width, height: padding.bottom * 2)
        setSelected(0)
    }

    func generateChildrens() {
        backgroundColor = .white
        addSubview(segmentHolder)
        addSubview(pageHolder)
        segmentHolder.addSubview(segmentScrollView)
        segmentScrollView.addSubview(segmentContentView)
        segmentContentView.addSubview(segmentStackView)

        segmentHolderHeightConstraint = segmentHolder.heightAnchor.constraint(equalToConstant: 44.0)
        NSLayoutConstraint.activate([
            segmentHolderHeightConstraint,
            segmentHolder.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentHolder.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentHolder.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),

            segmentScrollView.leadingAnchor.constraint(equalTo: segmentHolder.leadingAnchor),
            segmentScrollView.trailingAnchor.constraint(equalTo: segmentHolder.trailingAnchor),
            segmentScrollView.topAnchor.constraint(equalTo: segmentHolder.topAnchor),
            segmentScrollView.bottomAnchor.constraint(equalTo: segmentHolder.bottomAnchor),

            segmentContentView.leadingAnchor.constraint(equalTo: segmentScrollView.leadingAnchor),
            segmentContentView.trailingAnchor.constraint(equalTo: segmentScrollView.trailingAnchor),
            segmentContentView.widthAnchor.constraint(equalTo: segmentScrollView.widthAnchor),
            segmentContentView.topAnchor.constraint(equalTo: segmentScrollView.topAnchor),
            segmentContentView.bottomAnchor.constraint(equalTo: segmentScrollView.bottomAnchor),
            segmentContentView.heightAnchor.constraint(equalTo: segmentHolder.heightAnchor),

            segmentStackView.leadingAnchor.constraint(equalTo: segmentContentView.leadingAnchor),
            segmentStackView.trailingAnchor.constraint(equalTo: segmentContentView.trailingAnchor),
            segmentStackView.topAnchor.constraint(equalTo: segmentContentView.topAnchor),
            segmentStackView.bottomAnchor.constraint(equalTo: segmentContentView.bottomAnchor),

            pageHolder.topAnchor.constraint(equalTo: segmentHolder.bottomAnchor),
            pageHolder.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageHolder.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageHolder.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UIColor {
    static var random: UIColor {
        UIColor(hue: CGFloat(drand48()), saturation: 1, brightness: 1, alpha: 1)
    }
}
