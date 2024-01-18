//
//  GetGasStationsUseCase.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/5/23.
//

import Foundation

protocol GetGasStationsUseCase {
    var gasStationRepository: GasStationRepository { get set }
    func execute(latitude: Double, longitude: Double, fuel: FuelType) -> GasStationsResult
}

class DefaultGetGasStationsUseCase: GetGasStationsUseCase {

    var gasStationRepository: GasStationRepository

    init(gasStationRepository: GasStationRepository) {
        self.gasStationRepository = gasStationRepository
    }

    func execute(latitude: Double, longitude: Double, fuel: FuelType) -> GasStationsResult {
        return gasStationRepository.getGasStations(latitude: latitude, longitude: longitude, fuel: fuel, limit: 10)
    }
}
