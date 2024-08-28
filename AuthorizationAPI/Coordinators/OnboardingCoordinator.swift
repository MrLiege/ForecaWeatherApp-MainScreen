//
//  OnboardingCoordinator.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 22.08.2024.
//

import Foundation
import SwiftUI
import Stinsen

final class OnboardingCoordinator: NavigationCoordinatable {
    var stack = Stinsen.NavigationStack<OnboardingCoordinator>(initial: \.start)
    
    @Root var start = makeStart
    
    private let authService: Authenticatable
    
    init(authService: Authenticatable) {
        self.authService = authService
    }
}

extension OnboardingCoordinator {
    @ViewBuilder
    func makeStart() -> some View {
        let viewModel = OnboardingViewModel(authService: authService)
        OnboardingView(viewModel: viewModel)
    }
}
