//
//  Environment.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/10/20.
//

import Foundation

public protocol Environment {

    /// The base URL for api
    var apiBaseURL: URL { get }
}


struct Live: Environment {
    var apiBaseURL: URL {
        return URL(string: "http://newsapi.org/v2/")!
    }
}
