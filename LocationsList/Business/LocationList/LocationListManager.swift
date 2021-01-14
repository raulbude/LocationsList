//
//  LocationListManager.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation

final class LocationListManager: LocationListUCI {
    // MARK: - Properties
    
    private let locationStringURL = "http://demo1042273.mockable.io/mylocations"
    
    // MARK: - LocationListUCI
    
    func getAllLocationsList(completion: @escaping (([LocationsList]?, String?) -> Void)) {
        guard let url = URL(string: locationStringURL) else {
            completion(nil, "Can't create URL from String")
            return
        }
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
          guard let data = data else {
            completion(nil, error?.localizedDescription)
            return
          }
          do {
            let listDTO = try JSONDecoder().decode(LocationListDTO.self, from: data)
            completion(listDTO.locations, nil)
          } catch {
            print(error)
            completion(nil, error.localizedDescription)
          }
        })
        task.resume()
    }
}
