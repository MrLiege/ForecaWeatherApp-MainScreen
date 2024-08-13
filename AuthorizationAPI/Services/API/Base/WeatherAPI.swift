//
//  WeatherAPI.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 11.08.2024.
//

import Foundation
import Moya
import Combine
import CombineMoya
import CoreLocation

final class WeatherAPIService {
    private let provider = Provider<WeatherEndpoint>()
}

extension WeatherAPIService: CurrentWeaherContainable {
    func getCurrentWeather(location: CLLocationCoordinate2D) -> AnyPublisher<CurrentWeather, MoyaError> {
        provider.requestPublisher(.current(location: location))
            .filterSuccessfulStatusCodes()
            .map(ServerCurrentWeatherResponse.self)
            .map { CurrentWeather(serverEntity: $0.current) }
            .mapError({ error in
                print(error.errorUserInfo)
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

protocol CurrentWeaherContainable {
    func getCurrentWeather(location: CLLocationCoordinate2D) -> AnyPublisher<CurrentWeather, MoyaError>
}
