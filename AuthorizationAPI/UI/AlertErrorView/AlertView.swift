//
//  AlertView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 12.08.2024.
//

import SwiftUI

struct AlertView: View {
    var message: String
    var retry: VoidAction
    
    var body: some View {
        VStack {
            Text("Ошибка")
                .font(.title)
                .padding()
            
            Text(message)
                .font(.body)
                .padding()
            
            Button(action: {
                retry()
            }) {
                Text("OK")
                    .frame(width: 280, height: 50)
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(20)
            }
            
            .padding()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .shadow(radius: 10)
    }
}

#Preview {
    AlertView(message: "Ошибка") {
        print("Retry")
    }
}
