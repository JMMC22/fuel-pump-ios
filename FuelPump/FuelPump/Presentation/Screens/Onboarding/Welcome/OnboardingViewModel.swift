//
//  OnboardingViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 6/7/23.
//

import Foundation
import CoreLocation
import Combine

final class OnboardingViewModel: OnboardingFlowState {

    @Published var isButtonEnabled: Bool = false

    private let locationManager: LocationManager
    private let fetchAllGasStationsUseCase: FetchAllGasStationsUseCase
    private var cancellables = Set<AnyCancellable>()

    init(locationManager: LocationManager = LocationManager.shared,
         fetchAllGasStationsUseCase: FetchAllGasStationsUseCase) {
        self.locationManager = locationManager
        self.fetchAllGasStationsUseCase = fetchAllGasStationsUseCase
    }

    func viewDidLoad() {
        fetchAndSaveAllGasStations()
        locationManager.requestLocationPermissions()
        subscribeToLocationStatus()
    }

    func navigateToFuelSelector() {
        path.append(OnboardingLink.onboardingFuelSelector)
    }
}

extension OnboardingViewModel {
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

extension OnboardingViewModel {
    private func fetchAndSaveAllGasStations() {
        fetchAllGasStationsUseCase
            .execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleSuccess)
            .store(in: &cancellables)
    }

    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("||DEBUG|| fetchAllGasStationsUseCase: FINISHED")
        case .failure(_):
            print("||DEBUG|| fetchAllGasStationsUseCase: ERROR")
        }
    }

    private func handleSuccess() {
        print("||DEBUG|| fetchAllGasStationsUseCase: OK")
    }
}

