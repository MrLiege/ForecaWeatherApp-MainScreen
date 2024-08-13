//
//  Gradient+Ext.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 13.08.2024.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static func skyGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.white, Color(.systemBlue)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}
