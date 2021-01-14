//
//  UserLocationUseCaseProvider.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation
import CoreLocation

final class UserLocationUseCaseProvider {
    // MARK: - Properties

    public var isLocationAccessDenied: Bool {
        locationPlugin.isAccessDenied
    }

    public var currentLocation: CLLocation? {
        locationPlugin.getCurrentLocation()
    }

    public var locationAccessUpdate: BoolCompletion?
    public var currentLocationUpdate: LocationCompletion?
    private var locationPlugin: LocationPlugin

    // MARK: - Init

    public init(locationPlugin: LocationPlugin) {
        self.locationPlugin = locationPlugin
    }

    // MARK: - LocationUC

    public func requestAccess() {
        locationPlugin.requestAccess()

        locationPlugin.locationAccessUpdate = { [weak self] in
            self?.locationAccessUpdate?($0)
        }

        locationPlugin.currentLocationUpdate = { [weak self] in
            self?.currentLocationUpdate?($0)
        }
    }

    public func startLocationUpdate() {
        locationPlugin.startUpdatingLocation()
    }

    public func stopLocationUpdate() {
        locationPlugin.stopUpdatingLocation()
    }
}
