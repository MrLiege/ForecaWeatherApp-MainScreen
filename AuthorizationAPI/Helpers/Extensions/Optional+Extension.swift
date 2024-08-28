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

extension Optional {
    var isNil: Bool { self == nil }
    var isNotNil: Bool { self != nil }
}

extension Optional where Wrapped == Date {
    var orNow: Date {
        self ?? .now
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double {
        self ?? .zero
    }
}
