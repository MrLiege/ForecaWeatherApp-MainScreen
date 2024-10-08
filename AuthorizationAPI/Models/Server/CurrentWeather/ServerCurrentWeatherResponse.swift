//
//  ServerCurrentWeatherResponse.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 10.08.2024.
//

import Foundation

struct ServerCurrentWeatherResponse: Decodable {
    let current: ServerCurrentWeather
}

struct ServerCurrentWeather: Decodable {
    let time, symbol, symbolPhrase: String?
    let temperature, feelsLikeTemp: Double?
    let relHumidity: Double?
    let dewPoint, windSpeed: Double?
    let windDir: Double?
    let windDirString: String?
    let windGust: Double?
    let precipProb, precipRate, cloudiness, thunderProb: Double?
    let uvIndex: Int?
    let pressure: Double?
    let visibility: Int?
}
