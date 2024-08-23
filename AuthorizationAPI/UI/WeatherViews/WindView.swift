//
//  WindView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 12.08.2024.
//

import SwiftUI

struct WindView: View {
    let relHumidity: Double?
    let windSpeed: Double
    let windDir: Double?
    let windGust: Double?
    
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
                    textForWind(title: "Влажность: ", value: relHumidity ?? 0, unitMeas: "%")
                    textForWind(title: "Скорость: ", value: relHumidity ?? 0, unitMeas: "м/с")
                    textForWind(title: "Направление: ", value: relHumidity ?? 0, unitMeas: "°")
                    textForWind(title: "Порыв: ", value: relHumidity ?? 0, unitMeas: "м/с")
                }
                Spacer()
            }
        }
        .padding()
        .background(Color.panelInfoColor)
        .cornerRadius(25)
    }
}

private extension WindView {
    @ViewBuilder
    func textForWind(title: String, value: Double, unitMeas: String) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .regular, design: .default))
            .foregroundColor(.white)
        + Text("\(Int(value))")
            .font(.system(size: 20, weight: .semibold, design: .default))
            .foregroundColor(.white)
        + Text(unitMeas)
            .font(.system(size: 20, weight: .semibold, design: .default))
            .foregroundColor(.white)
    }
}

//#Preview {
//    WindView()
//        .background(Color(.systemBlue))
//}
