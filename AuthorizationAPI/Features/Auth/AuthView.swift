//
//  AuthView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 25.08.2024.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject private var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        LoadableView(state: viewModel.output.contentState) {
            SignIn(viewModel: viewModel)
        } onAppear: {
            
        } retry: {
            
        }
        .navigationBarHidden(true)
    }
}
