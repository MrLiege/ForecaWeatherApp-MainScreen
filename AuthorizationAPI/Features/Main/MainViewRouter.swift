//
//  MainViewRouter.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import Foundation

protocol MainViewRouter: AnyObject {
    func routeToCities()
    func routeToSettings()
}

extension MainCoordinator: MainViewRouter {
    func routeToCities() {
        self.route(to: \.cities)
        print("Это экран с городами")
    }
    
    func routeToSettings() {
        self.route(to: \.settings)
    }
}
