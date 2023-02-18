//
//  GasStationListViewModel.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Foundation

class GasStationListViewModel: ObservableObject {

    private let getGasStationsUseCase: GetGasStationsUseCase

    init(getGasStationsUseCase: GetGasStationsUseCase) {
        self.getGasStationsUseCase = getGasStationsUseCase
    }
    
    func getAllGasStation() async {
        do {
            var response = try await getGasStationsUseCase.execute()
            print(response.gasStations)
        } catch {
            
        }
    }
}
