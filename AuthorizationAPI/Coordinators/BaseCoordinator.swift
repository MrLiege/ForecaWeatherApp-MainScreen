//
//  BaseCoordinator.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 22.08.2024.
//

import Foundation
import SwiftUI
import Stinsen
import Combine

final class BaseCoordinator: NavigationCoordinatable {
    var stack: Stinsen.NavigationStack<BaseCoordinator>
    
    // MARK: - Roots
    @Root var auth = makeAuth
    @Root var start = makeMain
    @Root var onboarding = makeOnboarding
    
    @Injected private var authService: Authenticatable
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        switch UserStorage.shared.appState {
        case .auth:
            stack = .init(initial: \.auth)
        case .onboarding:
            stack = .init(initial: \.onboarding)
        case .main:
            stack = .init(initial: \.start)
        }
        
        bindAuthState()
    }
    
    func makeMain() -> NavigationViewCoordinator<MainCoordinator> {
        NavigationViewCoordinator(MainCoordinator())
    }
    
    func makeAuth() -> NavigationViewCoordinator<AuthCoordinator> {
        NavigationViewCoordinator(AuthCoordinator(authService: authService))
    }
    
    func makeOnboarding() -> NavigationViewCoordinator<OnboardingCoordinator> {
        NavigationViewCoordinator(OnboardingCoordinator(authService: authService))
    }
}

extension BaseCoordinator {
    func bindAuthState() {
        authService.authCompleted
            .sink { [weak self] state in
                self?.changeRoot(with: state)
            }
            .store(in: &cancellables)
    }
    
    func changeRoot(with authState: AuthState) {
        switch authState {
        case .success:
            UserStorage.shared.appState = .onboarding
            root(\.onboarding)
        case .onboardingDone:
            UserStorage.shared.appState = .main
            root(\.start)
            print("Переход в MainCoordinator")
        default:
            break
        }
    }
}
