//
//  GasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation

protocol GasStationRepository {
    func getAllGasStations() async throws -> GetAllGasStation
}
