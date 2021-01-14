//
//  LocationListPresenter.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation

protocol LocationListPresenter {
    var view: LocationListViewProtocol? { get set }
    var locationAccessUpdate: BoolCompletion? { get set }
    var isLocationAccessDenied: Bool { get }

    func getAllLocations()
}

protocol LocationListViewProtocol: class {
    func didReceiveLocations()
    func didFailToReceiveLocations(with error: String)
}
