//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/10/20.
//

import Foundation

public enum NetworkingError: LocalizedError {
    case none
    case malformedDataReceived
    case nonParsableErrorReceived
    case failedReason(String, Int)
    case noInternetConnection

    public var description: String {
        switch self {
        case .none: return ""
        case .malformedDataReceived:
            return "Data couldn't be read from server. Please try again later."
        case .nonParsableErrorReceived:
            return "Data couldn't be parsed from response. Please try again later."
        case .failedReason(let reason, _): return reason
        case .noInternetConnection:
            return "The internet connection appears to be offline."
        }
    }

    public var code: Int {
        switch self {
        case .failedReason(_, let code):
            return code
        default:
            return 0
        }
    }
}
