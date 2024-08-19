//
//  WeatherEndpoint.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 10.08.2024.
//

import Foundation
import Moya
import CoreLocation

enum WeatherEndpoint: TargetType {
    case current(location: CLLocationCoordinate2D)
    case daily(location: CLLocationCoordinate2D)
    
    var baseURL: URL {
        guard let url = URL(string: "https://pfa.foreca.com/api/v1") else {
            fatalError("Incorrect \(self) baseURL!")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .current(let location):
            return "current/\(map(location: location))"
        case .daily(let location):
            return "forecast/daily/\(map(location: location))"
        }
    }
        
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        .requestParameters(
            parameters: ["lang" : UserStorage.shared.responseLanguage.rawValue,
                         "tempunit" : UserStorage.shared.temperatureUnit],
            encoding: URLEncoding.default
        )
    }
    
    var headers: [String : String]? {
        guard let token = UserStorage.shared.token else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }
}

private extension WeatherEndpoint {
    func map(location: CLLocationCoordinate2D) -> String {
        "\(location.latitude),\(location.longitude)"
    }
}
