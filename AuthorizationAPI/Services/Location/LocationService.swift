//
//  LocationService.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 11.08.2024.
//

import Foundation
import CoreLocation
import Combine

protocol LocationServiceProtocol {
    var currentLocation: CurrentValueSubject<CLLocationCoordinate2D?, Never> { get }
    func requestLocation()
}

final class LocationService: NSObject, LocationServiceProtocol {
    let currentLocation = CurrentValueSubject<CLLocationCoordinate2D?, Never>(nil)
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let sortedLocations = locations.sorted { $0.horizontalAccuracy < $1.horizontalAccuracy }
        if let location = sortedLocations.first {
            currentLocation.send(location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error with your loaction.")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Location access denied")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        @unknown default:
            break
        }
    }
}
