//
//  Optional+Extension.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
    
    var isNotNilOrEmpty: Bool {
        guard let self else { return false }
        return !self.isEmpty
    }
}
