//
//  LoadableView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 11.08.2024.
//

import SwiftUI

enum LoadableViewState {
    case error(message: String?)
    case loaded
    case loading
}

struct LoadableView<Content: View>: View {
    @State private var showAlert = false
    @State private var errorMessage: String?
    
    let state: LoadableViewState
    let content: () -> Content
    let onAppear: VoidAction
    let retry: VoidAction
    
    var body: some View {
        ZStack {
            Group {
                switch state {
                case .error(let message):
                    content()
                        .blur(radius: 10)
                        .onAppear {
                            errorMessage = message
                            showAlert = true
                        }
                case .loaded:
                    content()
                case .loading:
                    LoadingProgressView()
                        .onAppear(perform: retry)
                }
            }
            
            if showAlert {
                Color.white.opacity(0.4).edgesIgnoringSafeArea(.all)

                AlertView(message: errorMessage ?? "Error") {
                    retry()
                    showAlert = false
                }
                .padding(.horizontal)
            }
        }
        .onAppear(perform: onAppear)
    }
}

#Preview {
    LoadableView(state: .loading) {
        EmptyView()
    } onAppear: {
        print("onAppear")
    } retry: {
        print("retry")
    }

}
