//
//  UserStorage.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation

protocol UserStorageProtocol {
    var token: String? { get set }
}


final class UserStorage: UserStorageProtocol {
    static let shared = UserStorage()
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    // MARK: - Access Token
    var token: String? {
        get {
            defaults.string(forKey: UserStorageKey.token.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: UserStorageKey.token.rawValue)
        }
    }
}

enum UserStorageKey: String {
    case token
}
