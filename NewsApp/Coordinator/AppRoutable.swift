//
//  AppRoutable.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/10/20.
//

import Foundation

public protocol AppRoutable {}

enum AppRoute: AppRoutable {
    case detail(Article)
}
