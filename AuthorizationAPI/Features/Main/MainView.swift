//
//  MainView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        LoadableView(state: viewModel.output.contentState, content: {
            WeatherView(viewModel: viewModel)
        }, onAppear: {
            viewModel.input.onAppear.send(())
        }, retry: {
            viewModel.retry()
        })
    }
}

#Preview {
    MainView()
}
