//
//  NetworkingRouter.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/10/20.
//

import Foundation
import Alamofire

/// The encoder to use for the request
public enum RequestEncoder {
    case none
    case json(Parameters?)
    case url(Parameters?)
    case query(Parameters?)
}

public enum RequestMethod {
    case connect
    case delete
    case get
    case head
    case options
    case patch
    case post
    case put
    case trace
}

public protocol NetworkingRouter: URLRequestConvertible {

    /// The headers required for every requests
    var headers: HTTPHeaders { get }

    /// The path of the endpoint
    var path: String { get }

    /// The httpMethod for endpoint
    var httpMethod: RequestMethod { get }

    /// The encoder to be used for the request encoding
    var encoders: [RequestEncoder] { get }

    /// The request
    func getRequest() throws -> URLRequest
}

public extension NetworkingRouter {

    /// Authorization header is put through here to each router
    var headers: HTTPHeaders {
        return Config.default.httpHeaders()
    }

    /// Create the urlRequest
    func getRequest() throws -> URLRequest  {

        /// the base url
        let baseURL = Config.default.serverURL

        /// create request
        var urlRequest = URLRequest(url: URL(string: baseURL.absoluteString + path)!)
        headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.name) }

        /// set request method
        switch httpMethod {
        case .connect:
            urlRequest.httpMethod = HTTPMethod.connect.rawValue
        case .delete:
            urlRequest.httpMethod = HTTPMethod.delete.rawValue
        case .get:
            urlRequest.httpMethod = HTTPMethod.get.rawValue
        case .head:
            urlRequest.httpMethod = HTTPMethod.head.rawValue
        case .options:
            urlRequest.httpMethod = HTTPMethod.options.rawValue
        case .patch:
            urlRequest.httpMethod = HTTPMethod.patch.rawValue
        case .post:
            urlRequest.httpMethod = HTTPMethod.post.rawValue
        case .put:
            urlRequest.httpMethod = HTTPMethod.put.rawValue
        case .trace:
            urlRequest.httpMethod = HTTPMethod.trace.rawValue
        }

        /// Set encoder
        /// Set encoder
        try encoders.forEach { routeEncoder in
            switch routeEncoder {
            case .json(let parameters):
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            case .query(let parameters):
                urlRequest = try URLEncoding.queryString.encode(urlRequest, with: parameters)
            case .url(let parameters):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            case .none:
                break
            }
        }

        /// return request
        return urlRequest
    }

    /// The base protocol implementation
    func asURLRequest() throws -> URLRequest {
        return try getRequest()
    }
}
