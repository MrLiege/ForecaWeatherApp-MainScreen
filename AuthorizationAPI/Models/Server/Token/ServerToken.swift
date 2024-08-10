//
//  ServerToken.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation

struct ServerToken: Decodable {
    let accessToken: String?
    let tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
}
