//
//  LocationListManager.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation
import RealmSwift

final class LocationListManager: LocationListUCI {
    // MARK: - Properties
    
    private let locationStringURL = "http://demo1042273.mockable.io/mylocations"
    private var realmDB: Realm?
    
    // MARK: - Init
    
    init() {
        do {
            self.realmDB = try Realm()
        } catch {
            print(error)
        }
    }
    
    // MARK: - LocationListUCI
    
    func getAllLocationsList(completion: @escaping (([Location]?, String?) -> Void)) {
        getLocationsFromDB(completion: completion)
    }
    
    func getLocation(for label: String) -> Location? {
        guard let realmDB = realmDB else { return nil }
        let location = Array(realmDB.objects(Location.self)).first { $0.label == label }
        return location
    }
    
    // MARK: - Private Functions
    
    private func saveLocationsInDB(_ locations: [Location]) {
        guard let realmDB = realmDB else { return }
        DispatchQueue.main.async {
            do {
                try realmDB.write {
                    realmDB.add(locations)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func getLocationsFromApi(completion: @escaping (([Location]?, String?) -> Void)) {
        guard let url = URL(string: locationStringURL) else {
            completion(nil, "Can't create URL from String")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
          guard let data = data else {
            completion(nil, error?.localizedDescription)
            return
          }
          do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                print(json)
                let listDTO = LocationListDTO(json: json)
                self?.saveLocationsInDB(listDTO.locations)
                completion(listDTO.locations, nil)
            }
          } catch {
            print(error)
            completion(nil, error.localizedDescription)
          }
        })
        task.resume()
    }
    
    private func getLocationsFromDB(completion: @escaping (([Location]?, String?) -> Void)) {
        guard let realmDB = realmDB else {
            getLocationsFromApi(completion: completion)
            return
        }
        let locations = Array(realmDB.objects(Location.self))
        if locations.isEmpty {
            getLocationsFromApi(completion: completion)
            return
        }
        completion(locations, nil)
    }
}
