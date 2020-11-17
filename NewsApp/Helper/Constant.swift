//
//  Constant.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/10/20.
//

import Foundation
import UIKit

enum Constant {

    enum Token {
        static let token = "5fc4b266140b48ce8c7036da51f261a6"
    }

    /// the alert actions
    enum AlertAction {
        case ok
        case cancel
        case delete

        var title: String {
            switch self {
            case .ok:
                return "OK"
            case .cancel:
                return "Cancel"
            case .delete:
                return "Delete"
            }
        }

        var style: UIAlertAction.Style {
            switch self {
            case .ok, .cancel:
                return .default
            case .delete:
                return .destructive
            }
        }
    }
}
