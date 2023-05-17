//
//  GetGasStationsUseCase.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Combine

protocol GetAllGasStationsUseCase {
    var gasStationRepository: GasStationRepository { get set }
    func execute() -> AnyPublisher<GetAllGasStation, Error>
}

class DefaultGetAllGasStationsUseCase: GetAllGasStationsUseCase {

    var gasStationRepository: GasStationRepository

    init(gasStationRepository: GasStationRepository) {
        self.gasStationRepository = gasStationRepository
    }

    func execute() -> AnyPublisher<GetAllGasStation, Error> {
        return gasStationRepository.getAllGasStations()
    }
}
