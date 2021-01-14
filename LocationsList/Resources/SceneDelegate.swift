//
//  SceneDelegate.swift
//  LocationsList
//
//  Created by Raul Bude on 12.01.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var appCore: AppCore?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        appCore = ConcreteAppCore(window: window)
        appCore?.start()
        
        appCore?.locationUseCaseProvider.requestAccess()
        
        window.makeKeyAndVisible()
    }
}

