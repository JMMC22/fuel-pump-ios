//
//  OnboardingViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 6/7/23.
//

import Foundation
import CoreLocation
import Combine

class OnboardingViewModel: ObservableObject {

    @Published var isButtonEnabled: Bool = false

    private let locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()

    init(locationManager: LocationManager = LocationManager.shared) {
        self.locationManager = locationManager
    }

    func viewDidLoad() {
        locationManager.requestLocationPermissions()
        subscribeToLocationStatus()
    }

    private func subscribeToLocationStatus() {
        locationManager.$status.sink { status in
            switch status {
            case .notDetermined:
                self.locationManager.requestLocationPermissions()
            case .authorizedAlways, .authorizedWhenInUse:
                print("||DEBUG|| Location permissions: APPROVED")
                self.isButtonEnabled = true
            default:
                print("||DEBUG|| Location permissions: DENIED")
                self.isButtonEnabled = false
            }
        }.store(in: &cancellables)
    }
}
