//
//  GetGasStationsUseCase.swift
//  FuelPump
//
//  Created by Jose Mari on 18/2/23.
//

import Foundation

protocol GetGasStationsUseCase {

    var gasStationRepository: GasStationRepository { get set }
    func execute() async throws -> GetAllGasStation
}

class DefaultGetGasStationsUseCase: GetGasStationsUseCase {
    
    var gasStationRepository: GasStationRepository
    
    init(gasStationRepository: GasStationRepository) {
        self.gasStationRepository = gasStationRepository
    }
    
    func execute() async throws -> GetAllGasStation {
        do {
            return try await gasStationRepository.getAllGasStations()
        } catch let error {
            throw error
        }
    }
}
