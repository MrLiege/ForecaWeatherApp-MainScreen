//
//  UpdateScreen.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 26.08.2024.
//

import SwiftUI

struct UpdateScreen: View {
    var body: some View {
        VStack {
            VStack {
                headingText
                subtitleText
            }
            .padding()
            .background(Color(.systemTeal).opacity(0.3))
            .cornerRadius(25)
            
            updateButton
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}

extension UpdateScreen {
    private func openAppStore() {
        if let url = URL(string: "https://apps.apple.com/ru/app/%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0/id1069513131") {
            UIApplication.shared.open(url)
        }
    }
}

extension UpdateScreen {
    @ViewBuilder
    private var headingText: some View {
        Text("Обновите приложение")
            .headingStyle()
    }
    
    @ViewBuilder
    private var subtitleText: some View {
        Text("Ваша версия устарела и больше не поддерживается")
            .subtitleStyle()
    }
    
    @ViewBuilder
    private var updateButton: some View {
        Button(action: openAppStore) {
            Text("Обновить")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient.saladGradient())
                .cornerRadius(40)
                .padding()
        }
        .padding(.top, 40)
    }
}

#Preview {
    UpdateScreen()
}
