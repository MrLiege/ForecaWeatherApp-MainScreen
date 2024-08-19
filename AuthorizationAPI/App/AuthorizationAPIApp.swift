//
//  AuthorizationAPIApp.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import SwiftUI

@main
struct AuthorizationAPIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            BaseCoordinator().view()
        }
    }
}
