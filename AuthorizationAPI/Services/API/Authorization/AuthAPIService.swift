//
//  AuthAPIService.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya

protocol AuthAPIServiceProtocol {
    func postToken() -> AnyPublisher<Token, MoyaError>
}

final class AuthAPIService: AuthAPIServiceProtocol {
    private let provider = Provider<AuthEndpoint>()
}

extension AuthAPIService {
    //MARK: - function for post Token
    func postToken() -> AnyPublisher<Token, MoyaError> {
        provider.requestPublisher(.postToken)
            .filterSuccessfulStatusCodes()
            .map(ServerToken.self)
            .map { TokenMapper().toLocal(serverEntity: $0) }
            .mapError({ error in
                print(error.errorUserInfo)
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
