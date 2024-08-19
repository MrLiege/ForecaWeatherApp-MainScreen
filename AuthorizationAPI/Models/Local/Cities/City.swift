//
//  City.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import Foundation
import CoreLocation

struct City: Identifiable {
    let id = UUID().hashValue
    let name: String
    let coordinate: CLLocationCoordinate2D
}

extension City {
    static var mockCities: [City] {
        [City(name: "Омск", coordinate: .init(latitude: 54.989347, longitude: 73.368221)),
         City(name: "Новосибирск", coordinate: .init(latitude: 55.030204, longitude: 82.920430)),
         City(name: "Москва", coordinate: .init(latitude: 55.75222, longitude: 37.61556)),
         City(name: "Санкт-Петербург", coordinate: .init(latitude: 59.93863, longitude: 30.31413)),
         City(name: "Афины", coordinate: .init(latitude: 37.570705, longitude: 26.976946)),
         City(name: "Милан", coordinate: .init(latitude: 45.464051, longitude: 9.189486)),
         City(name: "Стокгольм", coordinate: .init(latitude: 59.324612, longitude: 18.069628)),
         City(name: "Хельсинки", coordinate: .init(latitude: 60.169521, longitude: 24.935451)),
         City(name: "Монтерей", coordinate: .init(latitude: 38.412341, longitude: -79.580601)),
         City(name: "Саратов", coordinate: .init(latitude: 51.533562, longitude: 46.034266))
        ]
    }
}
