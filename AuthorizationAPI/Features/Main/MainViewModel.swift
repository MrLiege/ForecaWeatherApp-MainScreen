//
//  MainViewModel.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation
import Combine
import CombineExt

final class MainViewModel: ObservableObject {
    let input: Input
    
    private var userStorage: UserStorageProtocol
    private var authService: AuthAPIServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userStorage: UserStorageProtocol = UserStorage.shared, authService: AuthAPIServiceProtocol = AuthAPIService()) {
        self.input = Input()
        self.userStorage = userStorage
        self.authService = authService
        bind()
    }
}


private extension MainViewModel {
    func bind() {
        //MARK: - request Token
        let requestToken = input.onAppear.first()
            .filter { [weak self] in
                guard let self = self else { return false }
                return self.userStorage.token == nil
            }
            .map { [unowned self] in
                self.authService.postToken()
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        requestToken.failures()
            .sink { error in
                print(error)
            }
            .store(in: &cancellables)
        
        requestToken.values()
            .sink { [weak self] value in
                self?.userStorage.token = value.accessToken
            }
            .store(in: &cancellables)
    }
}

extension MainViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
}
