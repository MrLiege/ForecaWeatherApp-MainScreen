//
//  TempView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 12.08.2024.
//

import SwiftUI

struct TempView: View {
    let feelsLikeTemp: Double
    let symbolPhrase: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Температура:")
                    .font(.system(size: 16, weight: .thin, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
            }
            
            Divider()
                .background(Color(.systemGray2))
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ощущается: ")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    + Text("\(Int(feelsLikeTemp))°")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                    
                    Text("Описание: ")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    + Text(symbolPhrase)
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(Color.panelInfoColor)
        .cornerRadius(25)
    }
}

//#Preview {
//    TempView(viewModel: MainViewModel)
//        .background(Color(.systemBlue))
//}
