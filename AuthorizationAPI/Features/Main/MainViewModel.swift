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

final class MainViewModel: ObservableObject {
    let input: Input
    @Published var output: Output
    
    private var userStorage: UserStorageProtocol
    private var authService: AuthAPIServiceProtocol
    private var weatherService: WeatherAPIService
    private var locationService: LocationServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Warning about the received token
    private let onAuthComplete = PassthroughSubject<Void, Never>()
    
    init(userStorage: UserStorageProtocol = UserStorage.shared,
         authService: AuthAPIServiceProtocol = AuthAPIService(),
         weatherService: WeatherAPIService = WeatherAPIService(),
         locationService: LocationServiceProtocol = LocationService()) {
        self.input = Input()
        self.output = Output()
        self.userStorage = userStorage
        self.authService = authService
        self.weatherService = weatherService
        self.locationService = locationService
        bind()
    }
    
    func retry() {
        output.contentState = .loading
        input.onAppear.send(())
    }
}

private extension MainViewModel {
    func bind() {
        bindAuth()
        bindWeather()
    }
    
    func bindAuth() {
        //MARK: - IF you have token
        input.onAppear
            .filter { self.userStorage.token.isNotNilOrEmpty }
            .sink { [weak self] in
                self?.onAuthComplete.send()
            }
            .store(in: &cancellables)
        
        let request = input.onAppear
        //MARK: - But if you don't have token ...
            .filter { !self.userStorage.token.isNotNilOrEmpty }
            .map { [unowned self] in
                self.authService.postToken()
                    .materialize()
            }
            .switchToLatest()
            .share()
        
        request.failures()
            .sink { [weak self] error in
                self?.output.contentState = .error(message: error.localizedDescription)
            }
            .store(in: &cancellables)
        
        request.values()
            .sink { [weak self] value in
                self?.userStorage.token = value.accessToken
                self?.onAuthComplete.send()
            }
            .store(in: &cancellables)
    }
    
    func bindWeather() {
        //MARK: Skip first and delete nil
        let location = locationService.currentLocation
            .dropFirst()
            .compactMap { $0 }
        
        //MARK: Join flows(token with location) and get weather
        let weatherRequest = onAuthComplete.zip(location)
            .map { $0.1 }
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
}

extension MainViewModel {
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var contentState: LoadableViewState = .loading
        var model: CurrentWeather = .empty
    }
}
