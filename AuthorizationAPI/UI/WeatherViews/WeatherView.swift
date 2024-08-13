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
                TempView(feelsLikeTemp: viewModel.output.model.feelsLikeTemp, 
                         symbolPhrase: viewModel.output.model.symbolPhrase)
                
                WindView(relHumidity: viewModel.output.model.relHumidity, 
                         windSpeed: viewModel.output.model.windSpeed,
                         windDir: viewModel.output.model.windDir,
                         windGust: viewModel.output.model.windGust)
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
