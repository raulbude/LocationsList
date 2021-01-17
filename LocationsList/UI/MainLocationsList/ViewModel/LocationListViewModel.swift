//
//  LocationListViewModel.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation
import MapKit

final class LocationListViewModel {
    // MARK: - Properties
    
    var userLocation: CLLocation?
    private(set) var cellsVM = [LocationListCellViewModel]()
    
    // MARK: - Functions

    func format(_ locations: [Location]) {
        cellsVM = locations.compactMap {
            guard let userLocation = userLocation else {
                return LocationListCellViewModel(distance: -1, label: $0.label, locationImageStringUrl: $0.image)
            }
            let location = CLLocation(latitude: $0.lat, longitude: $0.lng)
            let distance = userLocation.distance(from: location) / 1000
            return LocationListCellViewModel(distance: distance, label: $0.label, locationImageStringUrl: $0.image)
        }
    }
}
