//
//  GasStationListViewModel.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Foundation
import Combine
import CoreLocation

class GasStationListViewModel: ObservableObject {

    @Published var result: GasStationsResult = GasStationsResult(gasStations: [], maxPrice: 0.0, minPrice: 0.0, date: "")
    @Published var isLoading: Bool = false
    @Published var error: Bool = false
    @Published var favouriteFuel: FuelType = .unknown

    private let getGasStationsUseCase: GetGasStationsUseCase
    private let getUserUseCase: GetUserUseCase
    private let locationManager: LocationManager
    private var cancellables = Set<AnyCancellable>()

    init(getGasStationsUseCase: GetGasStationsUseCase,
         getUserUseCase: GetUserUseCase,
         locationManager: LocationManager = LocationManager.shared) {
        self.getGasStationsUseCase = getGasStationsUseCase
        self.getUserUseCase = getUserUseCase
        self.locationManager = locationManager
    }

    func viewDidLoad() {
        getUser()
        subscribeToLocation()
        subscribeToLocationStatus()
    }
}

// MARK: - Location
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
            .receive(on: DispatchQueue.main)
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
            getGasStations(latitude: locationManager.lastLocation.latitude,
                           longitude: locationManager.lastLocation.longitude)
        }
    }
}

// MARK: - Get Gas Stations
extension GasStationListViewModel {
    func getGasStations(latitude: Double, longitude: Double) {
        guard latitude != 0, longitude != 0, favouriteFuel != .unknown else { return }
        getGasStationsUseCase.execute(by: favouriteFuel, latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleGetGasStationsCompletion, receiveValue: handleGetGasStationsResponse)
            .store(in: &cancellables)
    }
    
    private func handleGetGasStationsCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("||DEBUG|| getGasStations operation: Successfully completed.")
        case .failure(let error):
            print("||ERROR|| getGasStations operation failed with error: \(error)")
        }
    }

    private func handleGetGasStationsResponse(result: GasStationsResult) {
        print("||DEBUG|| getGasStations operation: \(result.gasStations.count)")
        self.result = result
    }
}
