//
//  SignIn.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 25.08.2024.
//

import SwiftUI

struct SignIn: View {
    
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            welcomeText
            inputPromptText
            inputFields
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

extension SignIn {
    
    @ViewBuilder
    private var welcomeText: some View {
        Text("Добро пожаловать!")
            .headingStyle()
    }
    
    @ViewBuilder
    private var inputPromptText: some View {
        Text("Введите свои данные")
            .subtitleStyle()
    }
    
    @ViewBuilder
    private var inputFields: some View {
        VStack(alignment: .leading) {
            TextField("Логин", text: $viewModel.output.login)
                .signTextFieldStyle()
                .padding([.bottom, .top], 20)

            SecureField("Пароль", text: $viewModel.output.password)
                .signTextFieldStyle()
                .padding(.bottom, 25)
            
            signInButton
                .disabled(!viewModel.output.isLoginButtonEnabled)
                .padding()
        }
    }
    
    @ViewBuilder
    private var signInButton: some View {
        Button(send: viewModel.input.onAuthTap) {
            Text("Войти")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient.saladGradient())
                .cornerRadius(20)
        }
    }
}
