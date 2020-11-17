//
//  BaseView.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/9/20.
//

import Foundation
import UIKit
import MBProgressHUD

/// The base view to be inherited by all screen child
open class BaseView: UIView {

    private var hud: MBProgressHUD?

    var indicate: Bool = false {
        didSet {
            if indicate {
                showIndicator()
            } else {
                hideIndicator()
            }
        }
    }

    /// Frame Initializer
    override public init(frame: CGRect) {
        super.init(frame: frame)
        create()
    }

    /// Coder initializer
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        create()
    }

    /// base function to create the subviews
    /// This function is override by different views to create their own subviews
    func create() {
        self.backgroundColor = .white
    }

    func showIndicator() {
        guard hud == nil else { return }
        self.hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud!.show(animated: true)
    }

    func hideIndicator() {
        hud?.hide(animated: true)
        hud = nil
    }

    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
}

