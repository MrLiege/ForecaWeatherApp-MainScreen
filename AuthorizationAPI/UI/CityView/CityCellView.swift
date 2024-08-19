//
//  CityCellView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import SwiftUI

struct CityCellView: View {
    let city: City
    
    var body: some View {
        HStack {
            Text(city.name)
                .fontWeight(.bold)
                .padding()
            Spacer()
            VStack {
                Text("Широта: \(city.coordinate.latitude, specifier: "%.3f")\n Долгота: \(city.coordinate.longitude, specifier: "%.3f")")
                    .fontWeight(.thin)
            }
            .padding()
        }
        .padding()
        .background(LinearGradient.dimSkyGradient())
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}


#Preview {
    CityCellView(city: City.init(name: "Саратов", coordinate: .init(latitude: 10, longitude: 20)))
}
