//
//  GetGasStationsUseCase.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/5/23.
//

import Foundation

protocol GetGasStationsUseCase {
    var gasStationRepository: GasStationRepository { get set }
    func execute(latitude: Double, longitude: Double) -> GasStationsResult
}

class DefaultGetGasStationsUseCase: GetGasStationsUseCase {

    var gasStationRepository: GasStationRepository

    init(gasStationRepository: GasStationRepository) {
        self.gasStationRepository = gasStationRepository
    }

    func execute(latitude: Double, longitude: Double) -> GasStationsResult {
        return gasStationRepository.getGasStations(latitude: latitude, longitude: longitude, limit: 10)
    }
}
