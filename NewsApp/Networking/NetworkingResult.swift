//
//  NetworkingResult.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/10/20.
//

import Foundation

public struct NetworkingResult {
    public var success: Bool
    public var error: NetworkingError
    public var result: Any?
    public var statusCode: Int
    public var pagination: Pagination?
    public var message: String
    public var errorCode: String?
    public var router: NetworkingRouter

    public init(success: Bool = true, error: NetworkingError = .none, result: Any? = nil, statusCode: Int = 0, pagination: Pagination? = nil, title: String = "", message: String = "", errorCode: String? = nil, router: NetworkingRouter) {
        self.success = success
        self.error = error
        self.result = result
        self.statusCode = statusCode
        self.pagination = pagination
        self.message = message
        self.errorCode = errorCode
        self.router = router
    }
}
