//
//  MainCoordinator.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import SwiftUI
import Stinsen
import Combine

final class MainCoordinator: NavigationCoordinatable {
    var stack = Stinsen.NavigationStack<MainCoordinator>(initial: \.start)
    
    // MARK: - Routes
    @Root var start = makeMainView
    
    @Route(.push) var cities = makeCities
    @Route(.fullScreen) var settings = makeSettings
    
    // MARK: - Dependencies
    @Injected private var authService: AuthAPIServiceProtocol
    @Injected private var locationService: LocationServiceProtocol
    @Injected private var weatherService: WeatherAPIService
    
    private let citySelected = CurrentValueSubject<City?, Never>(nil)
    private let onSettingsClose = PassthroughSubject<Void, Never>()
    private let tempUnitChanged = PassthroughSubject<String, Never>()
}

private extension MainCoordinator {
    @ViewBuilder
    func makeMainView() -> some View {
        let viewModel = MainViewModel(citySelected: citySelected,
                                      authService: authService,
                                      weatherService: weatherService,
                                      locationService: locationService,
                                      onSettingsClose: onSettingsClose, 
                                      tempUnitChanged: tempUnitChanged, router: self)
        
        MainView(viewModel: viewModel)
    }
    
    @ViewBuilder
    func makeCities() -> some View {
        let viewModel = CitiesViewModel(citySelected: citySelected,
                                        locationService: locationService,
                                        router: self)
        
        CitiesView(viewModel: viewModel)
    }
    
    @ViewBuilder
    func makeSettings() -> some View {
        let viewModel = SettingsViewModel(router: self,
                                          onSettingsClose: onSettingsClose, tempUnitChanged: tempUnitChanged)
        SettingsView(viewModel: viewModel)
    }
}

final class BaseCoordinator: NavigationCoordinatable {
    var stack = Stinsen.NavigationStack<BaseCoordinator>(initial: \.start)
    
    @Root var start = makeMain
    
    private func makeMain() -> NavigationViewCoordinator<MainCoordinator> {
        NavigationViewCoordinator(MainCoordinator())
    }
}
