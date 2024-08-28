//
//  AppDelegate.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 17.08.2024.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let authApiService = AuthAPIService()
    private lazy var authService = AuthService(apiService: authApiService)
    private let locationService = LocationService()
    private let apiSerice = WeatherAPIService()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("is working")
        UserStorage.shared.token = nil
        UserStorage.shared.isOnboardingDone = false
        registerDependencies()
        return true
    }
    
    private func registerDependencies() {
        Dependencies {
            Dependency { self.authApiService }
            Dependency { self.authService }
            Dependency { self.locationService }
            Dependency { self.apiSerice }
        }.build()
    }
}
