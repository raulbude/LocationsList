//
//  DetailedLocationViewModel.swift
//  LocationsList
//
//  Created by Raul Bude on 16.01.2021.
//

import Foundation

final class DetailedLocationViewModel {
    // MARK: - Properties
    
    var address: String?
    var label: String?
    var latitude: Double?
    var longitude: Double?
    
    // MARK: - Functions
    
    func format(location: Location) {
        self.address = location.address
        self.label = location.label
        self.latitude = location.lat
        self.longitude = location.lng
    }
}
