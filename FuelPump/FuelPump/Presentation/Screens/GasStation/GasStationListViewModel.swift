//
//  GasStationListViewModel.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Foundation
import Combine

class GasStationListViewModel: ObservableObject {

    @Published var gasStations: [GasStation] = []
    @Published var error: Bool = false

    private let getGasStationsUseCase: GetGasStationsUseCase
    private var cancellables = Set<AnyCancellable>()

    init(getGasStationsUseCase: GetGasStationsUseCase) {
        self.getGasStationsUseCase = getGasStationsUseCase
    }

    func getAllGasStations() {
        getGasStationsUseCase
            .execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: handleCompletion, receiveValue: handleSuccess)
            .store(in: &cancellables)
    }

    private func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            print("Request completed successfully")
        case .failure(_):
            self.error = true
        }
    }

    private func handleSuccess(response: GetAllGasStation) {
        self.gasStations = response.gasStations
    }
}
