//
//  NewsRouter.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/11/20.
//

import Foundation
import Alamofire

enum NewsRouter: NetworkingRouter {

    case headline(Parameters)
    case everything(Parameters)
    case source(Parameters)

    var path: String {
        switch self {
        case .headline:
            return "top-headlines"
        case .everything:
            return "everything"
        case .source:
            return "sources"
        }
    }

    var httpMethod: RequestMethod {
        return .get
    }

    var needNewsApiKey: Bool {
        return true
    }

    var encoders: [RequestEncoder] {
        switch self {
        case .everything(let params), .headline(let params), .source(let params):
            return [.url(params)]
        }
    }

}

