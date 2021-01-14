//
//  LocationListUCI.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation

protocol LocationListUCI: class {
    func getAllLocationsList(completion: @escaping LocationListUCO.Response)
}

protocol LocationListUCO {
    typealias Response = (([LocationsList]?, String?) -> Void)
}
