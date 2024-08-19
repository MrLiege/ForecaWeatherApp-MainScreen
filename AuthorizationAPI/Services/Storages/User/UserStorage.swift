//
//  UserStorage.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 08.08.2024.
//

import Foundation
import SwiftUI
import Combine

protocol UserStorageProtocol {
    var token: String? { get set }
    var accentColor: Color? { get set }
    var soundEnabled: Bool { get set }
    var temperatureUnit: String { get set }
    var selectedCity: City? { get set }
}

final class UserStorage: ObservableObject, UserStorageProtocol {
    
    static let shared = UserStorage()
    
    private let defaults = UserDefaults.standard
    
    private init() {
        self.accentColor = defaults.color(forKey: UserStorageKey.accentColor.rawValue) ?? .blue
        self.soundEnabled = defaults.bool(forKey: UserStorageKey.soundEnabled.rawValue)
        self.temperatureUnit = defaults.string(forKey: UserStorageKey.temperatureUnit.rawValue) ?? "C"
        self.selectedCity = defaults.city(forKey: UserStorageKey.selectedCity.rawValue)
    }
    
    
    @Published var accentColor: Color? {
        didSet {
            if let color = accentColor {
                defaults.setColor(color, forKey: UserStorageKey.accentColor.rawValue)
            }
        }
    }
    
    @Published var soundEnabled: Bool {
        didSet {
            defaults.set(soundEnabled, forKey: UserStorageKey.soundEnabled.rawValue)
        }
    }
    
    @Published var temperatureUnit: String {
        didSet {
            defaults.set(temperatureUnit, forKey: UserStorageKey.temperatureUnit.rawValue)
        }
    }
    
    @Published var selectedCity: City? {
        didSet {
            if let city = selectedCity {
                defaults.setCity(city, forKey: UserStorageKey.selectedCity.rawValue)
            }
        }
    }
    
    // MARK: - Access Token
    var token: String? {
        get {
            defaults.string(forKey: UserStorageKey.token.rawValue)
        }
        set {
            defaults.setValue(newValue, forKey: UserStorageKey.token.rawValue)
        }
    }
    
    // MARK: - Your Language
    var responseLanguage: ResponseLanguage {
        get {
            ResponseLanguage(rawValue: defaults.string(forKey: UserStorageKey.responseLanguage.rawValue).orEmpty) ?? .ru
        } set {
            defaults.setValue(newValue.rawValue, forKey: UserStorageKey.responseLanguage.rawValue)
        }
    }
}

enum UserStorageKey: String {
    case token
    case responseLanguage
    case accentColor
    case soundEnabled
    case temperatureUnit
    case selectedCity
}

extension UserDefaults {
    func color(forKey key: String) -> Color? {
        guard let data = data(forKey: key),
              let uiColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor else {
            return nil
        }
        return Color(uiColor)
    }
    
    func setColor(_ color: Color, forKey key: String) {
        let uiColor = UIColor(color)
        let data = try? NSKeyedArchiver.archivedData(withRootObject: uiColor, requiringSecureCoding: false)
        set(data, forKey: key)
    }
    
    func city(forKey key: String) -> City? {
        guard let data = data(forKey: key),
              let city = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? City else {
            return nil
        }
        return city
    }
    
    func setCity(_ city: City, forKey key: String) {
        let data = try? NSKeyedArchiver.archivedData(withRootObject: city, requiringSecureCoding: false)
        set(data, forKey: key)
    }
}
