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
    }
    
    func routeToSettings() {
        self.route(to: \.settings)
    }
}
