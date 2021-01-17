//
//  LocationListDTO.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation
import RealmSwift

class LocationListDTO: Object {
    @objc dynamic var status: String
    var locations: Array<Location>
    
    // MARK: - Init
    
    override init() {
        status = ""
        locations = []
        super.init()
    }
    
    init(json: [String: Any]) {
        guard let status = json["status"] as? String,
              let locationsAny = json["locations"] as? [[String: Any]] else {
            print("can't decode")
            self.status = ""
            self.locations = []
            return
        }
        self.status = status
        var locationsArray = [Location]()
        locationsAny.forEach {
            locationsArray.append(Location(json: $0))
        }
        locations = locationsArray
    }
}

class Location: Object {
    @objc dynamic var lat: Double
    @objc dynamic var lng: Double
    @objc dynamic var label: String
    @objc dynamic var address: String
    @objc dynamic var image: String
    
    //MARK: - Init
    
    override init() {
        lat = 0
        lng = 0
        label = ""
        address = ""
        image = ""
        super.init()
    }
    
    init(json: [String: Any]) {
        guard let lat = json["lat"] as? Double,
              let lng = json["lng"] as? Double,
              let label = json["label"] as? String,
              let address = json["address"] as? String,
              let image = json["image"] as? String else {
            print("can't decode")
            self.lat = 0
            self.lng = 0
            self.label = ""
            self.address = ""
            self.image = ""
            return
        }
        self.lat = lat
        self.lng = lng
        self.address = address
        self.label = label
        self.image = image
    }
}
