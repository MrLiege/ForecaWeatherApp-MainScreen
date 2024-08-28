//
//  UpdateCoordinator.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 27.08.2024.
//

import Foundation
import SwiftUI
import Stinsen

final class UpdateCoordinator: NavigationCoordinatable {
    var stack = Stinsen.NavigationStack<UpdateCoordinator>(initial: \.update)
    
    @Root var update = makeUpdate
}

extension UpdateCoordinator {
    @ViewBuilder
    func makeUpdate() -> some View {
        UpdateScreen()
    }
}
