//
//  CitiesRouter.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import Foundation

protocol CitiesRouter: AnyObject {
    func goBack()
}

extension MainCoordinator: CitiesRouter {
    func goBack() {
        self.popLast()
    }
}
