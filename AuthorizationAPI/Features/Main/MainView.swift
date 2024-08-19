//
//  MainView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        LoadableView(
            state: viewModel.output.contentState,
            content: {
                WeatherView(viewModel: viewModel,
                            accentColor: viewModel.output.accentColor)},
            onAppear: {
                viewModel.input.onAppear.send()},
            retry: {
                viewModel.retry()
            }
        )
        .navigationBarHidden(true)
        
    }
}
