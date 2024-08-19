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
    @Published var selectedColor: Color
    @Published var selectedTempUnit: String
    @Published var soundEnabled: Bool
    
    private var cancellables = Set<AnyCancellable>()
    private let onSettingsClose: PassthroughSubject<Void, Never>
    private let tempUnitChanged: PassthroughSubject<String, Never>
    private var tempUnitHasChanged = false
    
    private weak var router: SettingsRouter?
    
    init(router: SettingsRouter?,
         onSettingsClose: PassthroughSubject<Void, Never>,
         tempUnitChanged: PassthroughSubject<String, Never>) {
        self.input = Input()
        self.output = Output()
        self.router = router
        self.selectedColor = UserStorage.shared.accentColor ?? .white
        self.soundEnabled = UserStorage.shared.soundEnabled
        self.selectedTempUnit = UserStorage.shared.temperatureUnit
        self.onSettingsClose = onSettingsClose
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
                if self?.soundEnabled == true {
                    SoundEffect.shared.playSound(.CloseEffect)
                }
                if self?.tempUnitHasChanged == true {
                    self?.tempUnitChanged.send(self?.selectedTempUnit ?? "")
                }
                self?.onSettingsClose.send()
                self?.router?.exit()
            }
            .store(in: &cancellables)
    }
    
    func bindColorPicker() {
        $selectedColor
            .sink { color in
                UserStorage.shared.accentColor = color
            }
            .store(in: &cancellables)
    }
    
    func bindSoundToggle() {
        $soundEnabled
            .sink { soundEnabled in
                UserStorage.shared.soundEnabled = soundEnabled
            }
            .store(in: &cancellables)

    }
    
    func bindTempUnitPicker() {
        $selectedTempUnit
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
    
    struct Output { }
}
