//
//  LocationManager.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 7/7/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject {

    @Published var status: CLAuthorizationStatus = .notDetermined

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        status = locationManager.authorizationStatus
    }

    func requestLocationPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
    }
}
