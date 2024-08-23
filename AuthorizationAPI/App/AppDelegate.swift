//
//  AppDelegate.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    private let authApiService = AuthAPIService()
    private let locationService = LocationService()
    private let weatherService = WeatherAPIService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("is working")
        registerDependencies()
        return true
    }
    
    private func registerDependencies() {
        Dependencies {
            Dependency { self.authApiService }
            Dependency { self.locationService }
            Dependency { self.weatherService }
        }.build()
    }
}
