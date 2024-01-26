//
//  GasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Combine

protocol GasStationRepository {
    func fetchAllGasStations() -> AnyPublisher<Void, Error>
    func getNearestGasStations(by fuel: FuelType, latitude: Double, longitude: Double, limit: Int) -> AnyPublisher<GasStationsResult, Error>
    func maxPrice(of fuelType: FuelType, stations: [GasStation]) -> Double
    func minPrice(of fuelType: FuelType, stations: [GasStation]) -> Double
}
