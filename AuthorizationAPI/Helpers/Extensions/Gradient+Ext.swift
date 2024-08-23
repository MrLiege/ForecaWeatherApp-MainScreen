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
    
    static func darkSkyGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.black, Color(.systemBlue)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
    
    static func dimSkyGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: [Color.pink, Color(.systemBlue)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
    }
}
