//
//  GasStationListViewModel.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Foundation

class GasStationListViewModel: ObservableObject {

    @Published var gasStations: [GasStation] = []

    private let getGasStationsUseCase: GetGasStationsUseCase

    init(getGasStationsUseCase: GetGasStationsUseCase) {
        self.getGasStationsUseCase = getGasStationsUseCase
    }
    
    @MainActor
    func getAllGasStation() async {
        do {
            let response = try await getGasStationsUseCase.execute()
            self.gasStations = response.gasStations
        } catch {
            
        }
    }
}
