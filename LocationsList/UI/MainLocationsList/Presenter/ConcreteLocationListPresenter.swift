//
//  ConcreteLocationListPresenter.swift
//  LocationsList
//
//  Created by Raul Bude on 14.01.2021.
//

import Foundation

typealias LocationListPDP = (router: MainFlowRouter,
                             locationListUCI: LocationListUCI,
                             viewModel: LocationListViewModel,
                             userLocationProvider: UserLocationUseCaseProvider)

final class ConcreteLocationListPresenter: LocationListPresenter {
    // MARK: - Properties
    
    weak var view: LocationListViewProtocol?
    var locationAccessUpdate: BoolCompletion?
    var isLocationAccessDenied: Bool {
        userLocationProvider.isLocationAccessDenied
    }
    
    private let viewModel: LocationListViewModel
    private let locationListUCI: LocationListUCI
    private let router: MainFlowRouter
    private let userLocationProvider: UserLocationUseCaseProvider
    
    // MARK: - Init
    
    init(dependency: LocationListPDP) {
        self.viewModel = dependency.viewModel
        self.router = dependency.router
        self.locationListUCI = dependency.locationListUCI
        self.userLocationProvider = dependency.userLocationProvider
        
        self.userLocationProvider.locationAccessUpdate = { [weak self] in
            self?.locationAccessUpdate?($0)
        }
    }
    
    // MARK: - LocationListPresenter
    
    func getAllLocations() {
        locationListUCI.getAllLocationsList { [weak self] (locations, error) in
            guard let self = self else { return }
            guard let locations = locations else {
                self.view?.didFailToReceiveLocations(with: error ?? "")
                return
            }
            self.viewModel.format(locations)
            self.view?.didReceiveLocations()
        }
    }
}
