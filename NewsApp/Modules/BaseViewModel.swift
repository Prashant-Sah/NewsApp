//
//  BaseViewModel.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/9/20.
//

import Foundation
import Combine

/// The baseViewModel for every viewModel
open class BaseViewModel {

    /// The subcription cleanup bag
    public var bag = Set<AnyCancellable>()

    /// Routes trigger
    public var trigger = PassthroughSubject<AppRoutable, Never>()

    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }

    /// initializer
    public init() { }
}
