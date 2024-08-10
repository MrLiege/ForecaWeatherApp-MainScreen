//
//  TokenMapper.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation

final class TokenMapper: BaseModelMapper<ServerToken, Token> {
    override func toLocal(serverEntity: ServerToken) -> Token {
        .init(
            accessToken: serverEntity.accessToken.orEmpty,
            tokenType: serverEntity.tokenType.orEmpty
        )
    }
}
