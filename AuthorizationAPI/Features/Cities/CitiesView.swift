//
//  CitiesView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import SwiftUI
import CoreLocation

struct CitiesView: View {
    
    @StateObject private var viewModel: CitiesViewModel
    @FocusState private var isFocus: Bool
    
    init(viewModel: CitiesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                SearchBar(searchText: $viewModel.searchText, isFocus: $isFocus)
                    .padding()
                ForEach(viewModel.output.cities) { city in
                    CityCellView(city: city)
                        .onTapGesture {
                            viewModel.input.onPress.send(city)
                        }
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(LinearGradient.darkSkyGradient().ignoresSafeArea())
        .ignoresSafeArea(.keyboard)
    }
}
