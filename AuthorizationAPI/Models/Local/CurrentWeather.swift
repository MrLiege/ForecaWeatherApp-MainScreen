//
//  CurrentWeather.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 10.08.2024.
//

import Foundation

struct CurrentWeather {
    let time: String
    let temperature: Int
    let feelsLikeTemp: Double
    let windSpeed: Double
    let windDir: Double
    let windGust: Double
    let relHumidity: Double
    let symbolPhrase: String
    let symbol: String
    
    init(time: String, temperature: Int, feelsLikeTemp: Double, windSpeed: Double, windDir: Double, windGust: Double, relHumidity: Double, symbolPhrase: String, symbol: String) {
        self.time = time
        self.temperature = temperature
        self.feelsLikeTemp = feelsLikeTemp
        self.windSpeed = windSpeed
        self.windDir = windDir
        self.windGust = windGust
        self.relHumidity = relHumidity
        self.symbolPhrase = symbolPhrase
        self.symbol = symbol
    }
    
    init(serverEntity: ServerCurrentWeather) {
        self.init(
            time: serverEntity.time.orEmpty,
            temperature: Int(serverEntity.temperature ?? 0),
            feelsLikeTemp: serverEntity.feelsLikeTemp ?? 0,
            windSpeed: serverEntity.windSpeed ?? 0,
            windDir: serverEntity.windDir ?? 0,
            windGust: serverEntity.windGust ?? 0,
            relHumidity: serverEntity.relHumidity ?? 0,
            symbolPhrase: serverEntity.symbolPhrase.orEmpty,
            symbol: serverEntity.symbol.orEmpty
        )
    }
    
    static var empty: Self {
        .init(
            time: "",
            temperature: 0,
            feelsLikeTemp: 0,
            windSpeed: 0,
            windDir: 0,
            windGust: 0,
            relHumidity: 0,
            symbolPhrase: "",
            symbol: ""
        )
    }
}

