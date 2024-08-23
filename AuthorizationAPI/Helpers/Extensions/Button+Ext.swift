//
//  Button+Ext.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import Foundation
import SwiftUI
import Combine

extension Button {
    init(send: PassthroughSubject<Void, Never>, label: () -> Label) {
        self.init(action: send.send, label: label)
    }
    
    init<T>(send: PassthroughSubject<T, Never>, model: T, label: () -> Label) {
        self.init(
            action: { send.send(model) },
            label: label)
    }
}
