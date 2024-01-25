//
//  GetGasStationsUseCase.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Combine

protocol FetchAllGasStationsUseCase {
    var gasStationRepository: GasStationRepository { get set }
    func execute() -> AnyPublisher<Void, Error>
}

class DefaultFetchAllGasStationsUseCase: FetchAllGasStationsUseCase {

    var gasStationRepository: GasStationRepository

    init(gasStationRepository: GasStationRepository = DefaultGasStationRepository()) {
        self.gasStationRepository = gasStationRepository
    }

    func execute() -> AnyPublisher<Void, Error> {
        return gasStationRepository.fetchAllGasStations()
    }
}
