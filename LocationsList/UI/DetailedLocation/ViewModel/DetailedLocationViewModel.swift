//
//  DetailedLocationViewModel.swift
//  LocationsList
//
//  Created by Raul Bude on 16.01.2021.
//

import Foundation

final class DetailedLocationViewModel {
    // MARK: - Properties
    
    private(set) var address: String?
    private(set) var label: String?
    private(set) var latitude: Double?
    private(set) var longitude: Double?
    
    // MARK: - Functions
    
    func format(location: Location) {
        self.address = location.address
        self.label = location.label
        self.latitude = location.lat
        self.longitude = location.lng
    }
}
