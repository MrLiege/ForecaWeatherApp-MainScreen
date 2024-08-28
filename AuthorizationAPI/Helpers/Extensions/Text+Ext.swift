//
//  Text+Ext.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 27.08.2024.
//

import SwiftUI

extension Text {
    func headingStyle() -> some View {
        self
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(.bottom, 20)
    }
    
    func subtitleStyle() -> some View {
        self
            .font(.subheadline)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
    }
}
