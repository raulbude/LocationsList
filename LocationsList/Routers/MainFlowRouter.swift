//
//  MainFlowRouter.swift
//  LocationsList
//
//  Created by Raul Bude on 13.01.2021.
//

import UIKit

final class MainFlowRouter: Routable {
    // MARK: - Properties
    
    unowned var appCore: AppCore
    unowned var window: UIWindow
    
    // MARK: - Init
    
    init(window: UIWindow, appCore: AppCore) {
        self.window = window
        self.appCore = appCore
    }
    
    // MARK: - Routable
    
    func enter() {
        let locationListVM = LocationListViewModel()
        let dependency: LocationListPDP = (router: self,
                                           locationListUCI: appCore.locationListUCI,
                                           viewModel:  locationListVM,
                                           userLocationProvider: appCore.locationUseCaseProvider)
        let presenter = ConcreteLocationListPresenter(dependency: dependency)

        let locationListVC = LocationListViewController(viewModel: locationListVM, presenter: presenter)
        window.rootViewController = locationListVC
    }
    
    func goToDetailsScreen(for label: String) {
        guard let location = appCore.locationListUCI.getLocation(for: label) else { return }
        let detailedLocationVM = DetailedLocationViewModel()
        detailedLocationVM.format(location: location)
        let detailedLocationVC = DetailedLocationViewController(viewModel: detailedLocationVM)
        detailedLocationVC.modalPresentationStyle = .pageSheet
        window.rootViewController?.present(detailedLocationVC, animated: true, completion: nil)
    }
}
