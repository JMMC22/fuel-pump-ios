//
//  GetGasStationsUseCase.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/5/23.
//

import Foundation

protocol GetGasStationsUseCase {
    var gasStationRepository: GasStationRepository { get set }
    func execute() -> [GasStation]
}

class DefaultGetGasStationsUseCase: GetGasStationsUseCase {

    var gasStationRepository: GasStationRepository

    init(gasStationRepository: GasStationRepository) {
        self.gasStationRepository = gasStationRepository
    }

    func execute() -> [GasStation] {
        return gasStationRepository.getGasStations(limit: 10)
    }
}
