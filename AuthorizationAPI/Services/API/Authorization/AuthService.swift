//
//  AuthService.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 23.08.2024.
//

import Foundation
import Combine

enum AuthState {
    case failed
    case success
    case onboardingDone
}

protocol Authenticatable {
    var authCompleted: PassthroughSubject<AuthState, Never> { get }
    var token: String? { get }
    
    func login(username: String, password: String)
}

final class AuthService: Authenticatable {
    // MARK: API props
    let authCompleted = PassthroughSubject<AuthState, Never>()
    var token: String?
    
    // MARK: Private props
    private let apiService: AuthAPIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(apiService: AuthAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    // MARK: API Method
    func login(username: String, password: String) {
        let request = Just(())
            .filter { UserStorage.shared.token.isNil }
            .map { [unowned self] in
                self.apiService.postToken(username: username, password: password)
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        request
            .failures()
            .sink { [weak self] (error: Error) in
                print("AuthService: \(error.localizedDescription)")
                self?.authCompleted.send(.failed)
            }
            .store(in: &cancellables)
        
        request
            .values()
            .sink { [weak self] (value: Token) in
                self?.token = value.accessToken
                UserStorage.shared.token = value.accessToken
                print("Токен сохранен: \(value.accessToken)")
                self?.authCompleted.send(.success)
            }
            .store(in: &cancellables)
        
        if let token = UserStorage.shared.token, !token.isEmpty {
            authCompleted.send(.success)
        }
    }
}
