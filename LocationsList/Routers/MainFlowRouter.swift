//
//  MainFlowRouter.swift
//  LocationsList
//
//  Created by Raul Bude on 13.01.2021.
//

import UIKit

final class MainFlowRouter: Routable {
    // MARK: - Properties
    
    unowned var appCore: AppCore
    unowned var window: UIWindow
    
    // MARK: - Init
    
    init(window: UIWindow, appCore: AppCore) {
        self.window = window
        self.appCore = appCore
    }
    
    // MARK: - Routable
    
    func enter() {
        let locationListVC = LocationListViewController()
        let containerNavigationController = UINavigationController(rootViewController: locationListVC)
        window.rootViewController = containerNavigationController
    }
}
