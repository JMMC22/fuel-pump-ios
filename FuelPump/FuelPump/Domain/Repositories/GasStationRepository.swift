//
//  GasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Combine

protocol GasStationRepository {
    func getAllGasStations() -> AnyPublisher<GetAllGasStation, Error>
    func getGasStations(limit: Int) -> [GasStation]
    func maxPrice(of fuelType: FuelType) -> Double
    func minPrice(of fuelType: FuelType) -> Double
}
