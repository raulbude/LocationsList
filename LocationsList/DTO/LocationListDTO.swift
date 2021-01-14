//
//  LocationListDTO.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation

struct LocationListDTO {
    let status: String
    let locations: [LocationsList]
}

struct LocationsList {
    let lat: Double
    let lng: Double
    let label: String
    let address: String
    let imageStringURL: String
}

extension LocationListDTO: Decodable {
    enum CodingKeys: String, CodingKey {
        case status, locations
    }
}

extension LocationsList: Decodable {
    enum CodingKeys: String, CodingKey {
        case lat, lng, label, address
        case imageStringURL = "image"
    }
}
