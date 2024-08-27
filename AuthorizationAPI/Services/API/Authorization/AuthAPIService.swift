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
    func postToken(username: String, password: String) -> AnyPublisher<Token, MoyaError>
}

final class AuthAPIService: AuthAPIServiceProtocol {
    private let provider = Provider<AuthEndpoint>()
}

extension AuthAPIService {
    //MARK: - function for post Token
    func postToken(username: String, password: String) -> AnyPublisher<Token, MoyaError> {
        print("Запрос на получение токена отправлен")
        return provider.requestPublisher(.postToken(username: username, password: password))
            .filterSuccessfulStatusCodes()
            .map(ServerToken.self)
            .map { token in
                print("Токен получен: \(token.accessToken)")
                return TokenMapper().toLocal(serverEntity: token)
            }
            .mapError({ error in
                print("Ошибка при запросе токена: \(error.localizedDescription)")
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
