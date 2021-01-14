//
//  AppCore.swift
//  LocationsList
//
//  Created by Raul Bude on 13.01.2021.
//

import Foundation

protocol AppCore: class {
    var locationUseCaseProvider: UserLocationUseCaseProvider { get }
    
    func start()
}
