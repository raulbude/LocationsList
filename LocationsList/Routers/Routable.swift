//
//  Routable.swift
//  LocationsList
//
//  Created by Raul Bude on 13.01.2021.
//

import UIKit

protocol Routable: class {
    // MARK: - Properties
    
    var appCore: AppCore { get set }
    var window: UIWindow { get set }
    
    // MARK: - Functions
    
    func enter()
}
