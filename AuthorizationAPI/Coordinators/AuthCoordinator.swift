//
//  AuthCoordinator.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 22.08.2024.
//

import SwiftUI
import Stinsen

final class AuthCoordinator: NavigationCoordinatable {
    let stack: Stinsen.NavigationStack<AuthCoordinator> = .init(initial: \.start)
    
    @Root var start = makeStart
    
    private let authService: Authenticatable
    
    init(authService: Authenticatable) {
        self.authService = authService
    }
}

private extension AuthCoordinator {
    @ViewBuilder
    func makeStart() -> some View {
        let viewModel = AuthViewModel(authService: authService)
        AuthView(viewModel: viewModel)
    }
}
