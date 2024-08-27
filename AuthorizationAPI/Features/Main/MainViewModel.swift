//
//  MainViewModel.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation
import Combine
import CombineExt
import CoreLocation
import SwiftUI

final class MainViewModel: ObservableObject {
    let input: Input
    @Published var output: Output
    
    private var userStorage: UserStorageProtocol
    private var authService: AuthAPIServiceProtocol
    private var weatherService: WeatherAPIService
    private var locationService: LocationServiceProtocol
    private weak var router: MainViewRouter?
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Warning about the received token
    private let onAuthComplete = PassthroughSubject<Void, Never>()
    
    // MARK: External
    private let citySelected: CurrentValueSubject<City?, Never>
    private let tempUnitChanged: PassthroughSubject<String, Never>
    
    // MARK: Initialization
    init(citySelected: CurrentValueSubject<City?, Never>,
         userStorage: UserStorageProtocol = UserStorage.shared,
         authService: AuthAPIServiceProtocol = AuthAPIService(),
         weatherService: WeatherAPIService = WeatherAPIService(),
         locationService: LocationServiceProtocol = LocationService(),
         tempUnitChanged: PassthroughSubject<String, Never>,
         router: MainViewRouter?) {
        
        self.citySelected = citySelected
        self.input = Input()
        self.output = Output()
        self.userStorage = userStorage
        self.authService = authService
        self.weatherService = weatherService
        self.locationService = locationService
        self.tempUnitChanged = tempUnitChanged
        self.router = router
        bind()
    }
    
    func retry() {
        output.contentState = .loading
        input.onAppear.send(())
    }
}

private extension MainViewModel {
    func bind() {
        bindWeather()
        bindTransition()
        bindAccentColor()
        bindTempUnitChanged()
        bindSoundEnabled()
        
        input.onAppear
            .sink { [weak self] in
                self?.bindWeather()
            }
            .store(in: &cancellables)
    }
    
    func bindWeather() {
        output.contentState = .loading
        
        let location = locationService.currentLocation
            .compactMap { $0 }
        
        let citySelect = citySelected
            .compactMap { $0?.coordinate }
        
        let weatherRequest = location.merge(with: citySelect)
            .map { [unowned self] in
                self.weatherService.getCurrentWeather(location: $0)
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        weatherRequest.values()
            .sink { [weak self] value in
                self?.output.model = value
                self?.output.contentState = .loaded
            }
            .store(in: &cancellables)
        
        weatherRequest.failures()
            .sink { [weak self] error in
                self?.output.contentState = .error(message: error.localizedDescription)
            }
            .store(in: &cancellables)
    }
    
    private func bindTempUnitChanged() {
        tempUnitChanged
            .sink { [weak self] _ in
                self?.fetchWeather()
            }
            .store(in: &cancellables)
    }
    
    
    private func bindTransition() {
        input.onCityTap
            .sink { [weak self] in
                if self?.output.soundEnabled == true {
                    SoundEffect.shared.playSound(.OpenEffect)
                }
                print("onCityTap получен")
                self?.router?.routeToCities()
            }
            .store(in: &cancellables)
        
        input.onSettingTap
            .sink { [weak self] in
                if self?.output.soundEnabled == true {
                    SoundEffect.shared.playSound(.OpenEffect)
                }
                self?.router?.routeToSettings()
                        self?.onAuthComplete.send()
            }
            .store(in: &cancellables)
    }
    
    private func bindAccentColor() {
        UserStorage.shared.$accentColor
            .sink { [weak self] color in
                self?.output.accentColor = color
            }
            .store(in: &cancellables)
    }
    
    private func bindSoundEnabled() {
        UserStorage.shared.$soundEnabled
            .sink { [weak self] soundEnabled in
                self?.output.soundEnabled = soundEnabled
            }
            .store(in: &cancellables)
    }
    
    private func fetchWeather() {
        let coordinate = citySelected.value?.coordinate ?? locationService.currentLocation.value
        guard let coordinate = coordinate else {
            output.contentState = .error(message: "Не удалось получить координаты")
            return
        }
        
        let tempSelected = UserStorage.shared.$temperatureUnit
        
        let weatherRequest = tempSelected
            .map { [unowned self] _ in
                self.weatherService.getCurrentWeather(location: coordinate)
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        weatherRequest.values()
            .sink { [weak self] value in
                self?.output.model = value
                self?.output.contentState = .loaded
            }
            .store(in: &cancellables)
        
        weatherRequest.failures()
            .sink { [weak self] error in
                self?.output.contentState = .error(message: error.localizedDescription)
            }
            .store(in: &cancellables)
    }
}

extension MainViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onCityTap = PassthroughSubject<Void, Never>()
        let onSettingTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var contentState: LoadableViewState = .loading
        var model: CurrentWeather = .empty
        var accentColor: Color? = nil
        var soundEnabled: Bool = false
        var temperatureUnit: String = "C"
        var selectedCity: City? = nil
    }
}
