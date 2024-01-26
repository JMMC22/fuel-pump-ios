//
//  GetGasStationsUseCase.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/5/23.
//

import Foundation
import Combine

protocol GetGasStationsUseCase {
    var gasStationRepository: GasStationRepository { get set }
    func execute(by fuel: FuelType, latitude: Double, longitude: Double) -> AnyPublisher<GasStationsResult, Error>
}

class DefaultGetGasStationsUseCase: GetGasStationsUseCase {

    var gasStationRepository: GasStationRepository

    init(gasStationRepository: GasStationRepository) {
        self.gasStationRepository = gasStationRepository
    }

    func execute(by fuel: FuelType, latitude: Double, longitude: Double) -> AnyPublisher<GasStationsResult, Error> {
        return gasStationRepository.getNearestGasStations(by: fuel, latitude: latitude, longitude: longitude, limit: 10)
    }
}
