//
//  CitiesViewModel.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import Foundation
import Combine

final class CitiesViewModel: ObservableObject {
    // MARK: - Internal variables
    let input: Input
    @Published var output: Output
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - External
    private let citySelected: CurrentValueSubject<City?, Never>
    
    // MARK: - Services
    private weak var router: CitiesRouter?
    let locationService: LocationServiceProtocol
    
    //MARK: - Initialization
    init(citySelected: CurrentValueSubject<City?, Never>,
         locationService: LocationServiceProtocol,
         router: CitiesRouter?) {
        self.citySelected = citySelected
        self.locationService = locationService
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        appendCurrentLocation()
        bind()
    }
}

private extension CitiesViewModel {
    func bind() {
        input.onPress
            .sink { [weak self] city in
                self?.citySelected.send(city)
                UserStorage.shared.selectedCity = city
                self?.router?.goBack()
            }
            .store(in: &cancellables)
        
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterCities(by: text)
            }
            .store(in: &cancellables)
    }
    
    func appendCurrentLocation() {
        guard let coordinate = locationService.currentLocation.value else {
            return
        }
        output.cities.append(City(name: "Ваше местоположение", coordinate: coordinate))
    }
    
    func filterCities(by text: String) {
        if text.count >= 2 {
            output.cities = City.mockCities.filter { $0.name.lowercased().contains(text.lowercased()) }
        } else {
            output.cities = City.mockCities
        }
    }
}

extension CitiesViewModel {
    struct Input {
        let onPress = PassthroughSubject<City, Never>()
    }
    
    struct Output {
        var cities: [City] = City.mockCities
    }
}
