//
//  LocationPlugin.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation
import CoreLocation

final class LocationPlugin: NSObject {
    // MARK: - Properties

    var currentLocationDidUpdate: (() -> Void)?
    public var isAccessDenied: Bool {
        guard CLLocationManager.locationServicesEnabled() else { return true }
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied, .notDetermined:
            return true
        case .authorizedAlways, .authorizedWhenInUse:
            return false
        @unknown default:
            return false
        }
    }

    var currentLocation: CLLocation? {
        didSet {
            currentLocationDidUpdate?()
        }
    }
    public var locationAccessUpdate: ((Bool) -> Void)?
    public var currentLocationUpdate: ((CLLocation) -> Void)?

    private let locationManager: CLLocationManager
    private var locationUpdated = false

    // MARK: - Init

    public init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        
        super.init()
        self.locationManager.delegate = self
    }

    // MARK: - Functions

    func requestAccess() {
        locationManager.requestAlwaysAuthorization()
    }

    func startUpdatingLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func getCurrentLocation() -> CLLocation? {
        currentLocation
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationPlugin: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status != .notDetermined else { return }
        locationUpdated = (status == .authorizedWhenInUse || status == .authorizedAlways) && locationUpdated
        locationAccessUpdate?(status == .authorizedWhenInUse || status == .authorizedAlways)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.first, !locationUpdated else {
            return
        }
        self.currentLocation = currentLocation
        locationUpdated = true
        currentLocationUpdate?(currentLocation)
    }
}
