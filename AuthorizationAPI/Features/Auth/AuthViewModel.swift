//
//  AuthViewModel.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 25.08.2024.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    // MARK: - Variables
    let input: Input
    @Published var output: Output
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Services
    private let authService: Authenticatable
    
    init(authService: Authenticatable) {
        self.authService = authService
        self.input = Input()
        self.output = Output()
        bind()
    }
}

private extension AuthViewModel {
    func bind() {
        bindAuth()
    }
    
    func bindAuth() {
        input.onAuthTap
            .handleEvents(receiveOutput: { [weak self] in
                self?.replaceWithMockData()
                self?.output.contentState = .loading
            })
            .sink { [weak self] in
                guard let self = self else { return }
                self.authService.login(username: self.output.login, password: self.output.password)
            }
            .store(in: &cancellables)
        
        authService.authCompleted
            .filter { $0 == .success }
            .sink { [weak self] _ in
                if let token = self?.authService.token {
                    UserStorage.shared.token = token
                    print("Токен сохранен: \(token)")
                } else {
                    print("Токен не найден при авторизации")
                }
                self?.output.contentState = .loaded
            }
            .store(in: &cancellables)
        
        authService.authCompleted
            .filter { $0 == .failed }
            .mapToVoid()
            .sink { [weak self] in
                self?.output.contentState = .error(message: "Ошибка авторизации")
            }
            .store(in: &cancellables)
    }
    
    func replaceWithMockData() {
        #if DEBUG
        output.login = APISecureKeys.login
        output.password = APISecureKeys.password
        #endif
    }
}

extension AuthViewModel {
    struct Input {
        let onAuthTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var contentState: LoadableViewState = .loaded
        
        var login = ""
        var password = ""
        
        var isLoginButtonEnabled: Bool {
            !login.isEmpty && !password.isEmpty
        }
    }
}
