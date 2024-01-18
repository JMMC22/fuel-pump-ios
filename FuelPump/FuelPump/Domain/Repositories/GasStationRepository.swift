//
//  GasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Combine

protocol GasStationRepository {
    func fetchAllGasStations() -> AnyPublisher<Void, Error>
    func getGasStations(latitude: Double, longitude: Double, fuel: FuelType, limit: Int)  -> GasStationsResult
    func maxPrice(of fuelType: FuelType) -> Double
    func minPrice(of fuelType: FuelType) -> Double
}
