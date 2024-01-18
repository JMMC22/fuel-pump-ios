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
    @Published var lastLocation: CLLocationCoordinate2D = .init()

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        status = locationManager.authorizationStatus
    }

    func requestLocationPermissions() {
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.startUpdatingLocation()
    }

    func getDistance(to destination: Location) -> Double {
        let userLocation = Location(latitude: lastLocation.latitude.description, longitude: lastLocation.longitude.description)
        return userLocation.calculateDistance(to: destination)
    }
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        status = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location.coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("||ERROR|| locationManager: \(error.localizedDescription)")
    }
}
