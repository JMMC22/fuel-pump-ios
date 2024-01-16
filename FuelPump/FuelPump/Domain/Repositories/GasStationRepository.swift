//
//  GasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Combine

protocol GasStationRepository {
    func fetchAllGasStations() -> AnyPublisher<Void, Error>
    func getGasStations(latitude: Double, longitude: Double, limit: Int) -> [GasStation]
    func maxPrice(of fuelType: FuelType) -> Double
    func minPrice(of fuelType: FuelType) -> Double
}
