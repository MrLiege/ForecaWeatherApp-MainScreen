//
//  WeatherView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 12.08.2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: MainViewModel
    var accentColor: Color?
    
    var body: some View {
        VStack {
            Image(systemName: "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(viewModel.output.model.temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.accentColor)
                .padding()
            
            //MARK: Views with info
            Group {
                TempView(feelsLikeTemp: viewModel.output.model.feelsLikeTemp, 
                         symbolPhrase: viewModel.output.model.symbolPhrase)
                
                WindView(relHumidity: viewModel.output.model.relHumidity, 
                         windSpeed: viewModel.output.model.windSpeed,
                         windDir: viewModel.output.model.windDir,
                         windGust: viewModel.output.model.windGust)
            }
            .padding()
            .background(Color.panelInfoColor)
            .cornerRadius(25)
            
            Spacer()
            
            //MARK: Buttons (Screen cities and Screen settings)
            HStack {
                Button(send: viewModel.input.onCityTap) {
                    Image(systemName: "mappin.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(CustomButtonStyle())

                Button(send: viewModel.input.onSettingTap) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .background(backgroundWeatherView)
    }
}

extension WeatherView {
    @ViewBuilder
    private var backgroundWeatherView: some View {
        if let accentColor = accentColor {
            accentColor.ignoresSafeArea()
        } else {
            LinearGradient.skyGradient().ignoresSafeArea()
        }
    }
}
