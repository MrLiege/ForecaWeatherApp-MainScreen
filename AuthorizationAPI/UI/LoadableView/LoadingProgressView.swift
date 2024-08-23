//
//  LoadingProgressView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 11.08.2024.
//

import SwiftUI

struct LoadingProgressView: View {
    @State private var isAnimating = false
    
    let loadingText = "Loading..."
    
    var body: some View {
        ScrollView([]) {
            HStack(spacing: 0) {
                ForEach(Array(loadingText.enumerated()), id: \.offset) { index, letter in
                    Text(String(letter))
                        .font(.system(size: 80))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .background{ LinearGradient.skyGradient() }
                        .offset(y: isAnimating ? -20 : 0)
                        .shadow(color: isAnimating ? Color.panelInfoColor : Color.black,
                                radius: 1.5, x: 0, y: 2)
                        .animation(.easeInOut(duration: 0.9).repeatForever(autoreverses: true).delay(Double(index) * 0.1),
                                   value: isAnimating)
                }
            }
            .frame(maxWidth: .infinity)
            .onAppear {
                isAnimating = true
            }
            
        }
        .background {
            Color(.systemBlue).ignoresSafeArea(.all)
        }
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    LoadingProgressView()
        .background(Color(.systemBlue))
}
