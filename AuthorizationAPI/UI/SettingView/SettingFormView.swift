//
//  SettingFormView.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import SwiftUI

struct SettingFormView: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(send: viewModel.input.onExitTap) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            Form {
                 Section(header: Text("Настройки")) {
                     ColorPicker("Акцентный цвет", selection: $viewModel.selectedColor)
                         .padding()
                     
                     Toggle("Саунд тоггл", isOn: $viewModel.soundEnabled)
                         .padding()
                     
                     Picker("Единица измерения температуры", selection: $viewModel.selectedTempUnit) {
                         Text("Цельсий").tag("C")
                         Text("Фаренгейт").tag("F")
                     }
                     .pickerStyle(SegmentedPickerStyle())
                     .padding()
                 }
             }
         }
         .padding()
     }
 }
