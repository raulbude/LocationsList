//
//  ConcreteAppCore.swift
//  LocationsList
//
//  Created by Raul Bude on 13.01.2021.
//

import UIKit
import CoreLocation

final class ConcreteAppCore: AppCore {
    // MARK: - Properties
    
    let locationUseCaseProvider: UserLocationUseCaseProvider
    var locationListUCI: LocationListUCI {
        locationListManager
    }
    private let window: UIWindow
    private var rootRouter: Routable?
    private let locationListManager: LocationListManager
    
    // MARK: - Init
    
    init(window: UIWindow) {
        self.window = window
        locationUseCaseProvider = UserLocationUseCaseProvider(locationPlugin: LocationPlugin(locationManager: CLLocationManager()))
        locationListManager = LocationListManager()
        setupRouter()
    }
    
    // MARK: - AppCore
    
    func start() {
        rootRouter?.enter()
    }
    
    // MARK: - Private Functions
    
    func setupRouter() {
        rootRouter = MainFlowRouter(window: window, appCore: self)
    }
}

