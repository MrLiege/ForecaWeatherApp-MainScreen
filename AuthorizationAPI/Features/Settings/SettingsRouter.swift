//
//  SettingsRouter.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import Foundation

protocol SettingsRouter: AnyObject {
    func exit()
}

extension MainCoordinator: SettingsRouter {
    func exit() {
        self.popLast()
    }
}
