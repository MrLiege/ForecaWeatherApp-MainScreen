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
        EmptyView()
            .onAppear(perform: viewModel.input.onAppear.send)
    }
}

#Preview {
    MainView()
}
