//
//  OnboardingView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 23.08.2024.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel
    
    init(viewModel: OnboardingViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.output.currentStep) {
                ForEach(viewModel.output.steps) { step in
                    VStack {
                        Image(step.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                        Text(step.rawValue)
                            .headingStyle()
                        Text(step.subtitle)
                            .subtitleStyle()
                    }
                    .tag(step)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            pageIndicator
            
            if viewModel.output.isButtonVisible {
                Button(send: viewModel.input.onDone) {
                    Text("Начать")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding()
            } else {
                Button(action: viewModel.nextStep) {
                    Text("Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension OnboardingView {
    
    @ViewBuilder
    private var pageIndicator: some View {
        HStack {
            ForEach(viewModel.output.steps.indices, id: \.self) { index in
                Circle()
                    .fill(index == viewModel.output.steps.firstIndex(of: viewModel.output.currentStep) ? Color.green : Color.gray)
                    .frame(width: 10)
            }
        }
        .padding(.bottom, 20)
    }
}
