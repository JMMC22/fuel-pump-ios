//
//  GasStationListViewModel.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Foundation
import Combine

class GasStationListViewModel: GasStationListFlowState {

    @Published var gasStations: [GasStation] = []
    @Published var isLoading: Bool = false
    @Published var error: Bool = false

    private let getGasStationsUseCase: GetGasStationsUseCase
    private let locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()

    init(getGasStationsUseCase: GetGasStationsUseCase, locationManager: LocationManager = LocationManager.shared) {
        self.getGasStationsUseCase = getGasStationsUseCase
        self.locationManager = locationManager
    }
    
    func viewDidLoad() {
        locationManager.requestLocation()
        subscribeToLocation()
        subscribeToLocationStatus()
    }

    func getGasStations(latitude: Double, longitude: Double) {
        self.gasStations = getGasStationsUseCase.execute(latitude: latitude, longitude: longitude)
    }

    func navigateToGasStationDetails(_ station: GasStation) {
        presentedItem = .details(station)
    }
}

extension GasStationListViewModel {
    private func subscribeToLocationStatus() {
        locationManager.$status.sink { status in
            switch status {
            case .notDetermined:
                self.locationManager.requestLocationPermissions()
            case .authorizedAlways, .authorizedWhenInUse:
                print("||DEBUG|| Location permissions: APPROVED")
                self.locationManager.requestLocation()
            default:
                print("||DEBUG|| Location permissions: DENIED")
            }
        }.store(in: &cancellables)
    }

    private func subscribeToLocation() {
        locationManager.$lastLocation.sink { location in
            self.getGasStations(latitude: location.latitude, longitude: location.longitude)
        }.store(in: &cancellables)
    }
}
