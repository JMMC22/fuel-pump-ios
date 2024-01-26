//
//  GasStationListViewModel.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Foundation
import Combine

class GasStationListViewModel: ObservableObject {

    @Published var result: GasStationsResult = GasStationsResult(gasStations: [], maxPrice: 0.0, minPrice: 0.0, date: "")
    @Published var isLoading: Bool = false
    @Published var error: Bool = false
    @Published var favouriteFuel: FuelType = .dieselA

    private let getGasStationsUseCase: GetGasStationsUseCase
    private let getUserUseCase: GetUserUseCase
    private let locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()

    private var userLocation: Location = Location(latitude: "", longitude: "")

    init(getGasStationsUseCase: GetGasStationsUseCase,
         getUserUseCase: GetUserUseCase,
         locationManager: LocationManager = LocationManager.shared) {
        self.getGasStationsUseCase = getGasStationsUseCase
        self.getUserUseCase = getUserUseCase
        self.locationManager = locationManager
    }

    func viewDidLoad() {
        getUser()
        locationManager.requestLocation()
        subscribeToLocation()
        subscribeToLocationStatus()
    }

    func getGasStations(latitude: Double, longitude: Double) {
        let response = getGasStationsUseCase.execute(latitude: latitude, longitude: longitude, fuel: favouriteFuel)
        handleGetGasStations(response)
    }

    private func handleGetGasStations(_ response: GasStationsResult) {
        result = response
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

// MARK: - Get User
extension GasStationListViewModel {
    private func getUser() {
        getUserUseCase.execute()
            .sink(receiveCompletion: handleCompletion, receiveValue: handleResponse)
            .store(in: &cancellables)
    }

    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("||DEBUG|| getUser operation: Successfully completed.")
        case .failure(let error):
            print("||ERROR|| getUser operation failed with error: \(error)")
        }
    }

    private func handleResponse(user: User?) {
        if let user {
            favouriteFuel = user.fuelType
        }
    }
}
