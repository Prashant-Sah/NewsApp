//
//  AppLaunchBuilder.swift
//  NewsApp
//
//  Created by Prashant Sah on 11/16/20.
//

import Foundation
import Combine
import UIKit

final class AppLaunchBuilder {

    /// The launch options when app is launched
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?

    /// The key application or current application
    var application: UIApplication = UIApplication.shared

    /// the bag
    private var bag = Set<AnyCancellable>()

    /// The shared instance
    static let `default` = AppLaunchBuilder()
    private init() {}

    /// The window of the app
    private var window: UIWindow?

    /// The main coordinator for the app
    lazy var appCoordinator: Coordinator = { self.getAppCoordinator() }()

    /// Method to generate new app coordinator when the app launches
    /// - Parameter window: the window for the app
    @discardableResult
    func generateApplicationState(with window: UIWindow?) -> Bool {

        /// keep the refrence to window
        self.window = window

        // run the coordinator
        appCoordinator.start()

        //let the app starts
        return true
    }
}

extension AppLaunchBuilder {

    /// Method to initialize and create the app coordinator for the app
    ///
    /// - Returns: the appcoordinator
    private func getAppCoordinator() -> Coordinator {

        //chekc if the window was properly initialized
        guard let window = window else {
            fatalError("Window not initailized properly")
        }

        //set the root of window and make window key and visible
        let rootNavigationController = UINavigationController()
        window.rootViewController = rootNavigationController
        window.makeKeyAndVisible()

        return AppCoordinator(route: Route(rootController: rootNavigationController))
    }
}
