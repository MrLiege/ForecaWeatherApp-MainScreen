//
//  VIew+Ext.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 27.08.2024.
//

import SwiftUI

extension View {
    func signTextFieldStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
    }
}
