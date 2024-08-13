//
//  WindView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 12.08.2024.
//

import SwiftUI

struct WindView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Ветер:")
                    .font(.system(size: 16, weight: .thin, design: .rounded))
                    .foregroundColor(.white)
                
                Spacer()
            }
            
            Divider()
                .background(Color(.systemGray2))
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Влажность: ")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    + Text("\(Int(viewModel.output.model.relHumidity ?? 0))%")
                        .font(.system(size: 16, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                    
                    Text("Скорость: ")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    + Text("\(Int(viewModel.output.model.windSpeed)) м/с")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                    
                    Text("Направление: ")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    + Text("\(Int(viewModel.output.model.windDir ?? 0))°")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                    
                    Text("Порыв: ")
                        .font(.system(size: 16, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    + Text("\(Int(viewModel.output.model.windGust ?? 0)) м/с")
                        .font(.system(size: 20, weight: .semibold, design: .default))
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .padding()
        .background(Color("panelInfoColor"))
        .cornerRadius(25)
    }
}

//#Preview {
//    WindView()
//        .background(Color(.systemBlue))
//}
