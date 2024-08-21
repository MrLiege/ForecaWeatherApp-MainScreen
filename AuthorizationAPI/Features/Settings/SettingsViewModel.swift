//
//  SettingsViewModel.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import Foundation
import Combine
import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    let input: Input
    @Published var output: Output
    
    private var cancellables = Set<AnyCancellable>()
    private let tempUnitChanged: PassthroughSubject<String, Never>
    private var tempUnitHasChanged = false
    
    private weak var router: SettingsRouter?
    
    init(tempUnitChanged: PassthroughSubject<String, Never>,
         router: SettingsRouter?) {
        self.input = Input()
        self.output = Output(selectedColor: UserStorage.shared.accentColor ?? .white,
                             soundEnabled: UserStorage.shared.soundEnabled,
                             selectedTempUnit: UserStorage.shared.temperatureUnit)
        self.router = router
        self.tempUnitChanged = tempUnitChanged
        
        bind()
    }
}

extension SettingsViewModel {
    func bind() {
        bindExit()
        bindColorPicker()
        bindSoundToggle()
        bindTempUnitPicker()
    }
}

extension SettingsViewModel {
    func bindExit() {
        input.onExitTap
            .sink { [weak self] in
                if self?.output.soundEnabled == true {
                    SoundEffect.shared.playSound(.CloseEffect)
                }
                if self?.tempUnitHasChanged == true {
                    self?.tempUnitChanged.send(self?.output.selectedTempUnit ?? "")
                }
                self?.router?.exit()
            }
            .store(in: &cancellables)
    }
    
    func bindColorPicker() {
        $output
            .map(\.selectedColor)
            .sink { color in
                UserStorage.shared.accentColor = color
            }
            .store(in: &cancellables)
    }
    
    func bindSoundToggle() {
        $output
            .map(\.soundEnabled)
            .sink { soundEnabled in
                UserStorage.shared.soundEnabled = soundEnabled
            }
            .store(in: &cancellables)

    }
    
    func bindTempUnitPicker() {
        $output
            .map(\.selectedTempUnit)
            .sink { [weak self] tempUnit in
                UserStorage.shared.temperatureUnit = tempUnit
                self?.tempUnitHasChanged = true
            }
            .store(in: &cancellables)
    }
}

extension SettingsViewModel {
    struct Input { 
        let onExitTap = PassthroughSubject<Void, Never>()
        
    }
    
    struct Output {
        var selectedColor: Color
        var soundEnabled: Bool
        var selectedTempUnit: String
    }
}
