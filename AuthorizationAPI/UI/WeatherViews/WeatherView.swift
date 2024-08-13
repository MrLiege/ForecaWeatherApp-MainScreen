//
//  WeatherView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 12.08.2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(viewModel.output.model.temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
                .padding()
            
            Group {
                TempView(viewModel: viewModel)
                WindView(viewModel: viewModel)
            }
            .padding()
            .background(Color("panelInfoColor"))
            .cornerRadius(25)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background {
            Color(.systemBlue).ignoresSafeArea()
        }
    }
}

//#Preview {
//    WeatherView()
//}
