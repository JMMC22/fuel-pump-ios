//
//  DefaultGasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation
import Combine

final class DefaultGasStationRepository {

    private let cacheService: DataManager
    private let httpClient: HTTPClient

    init(dataManager: DataManager = RealmDataManager(RealmProvider.default),
         httpClient: HTTPClient = NetworkManager()) {
        self.cacheService = dataManager
        self.httpClient = httpClient
    }
}

extension DefaultGasStationRepository: GasStationRepository {

    func getGasStations(limit: Int) -> [GasStation] {
        var result: [GetAllGasStation] = []

        self.cacheService.fetch(GetAllGasStationRealm.self,
                                predicate: nil,
                                sorted: nil) { response in
            result = response.map { GetAllGasStation.mapFromRealmObject($0) }
        }

        return Array(result.first?.gasStations.prefix(limit) ?? [])
    }

    func fetchAllGasStations() -> AnyPublisher<Void, Error> {
        let endpoint = GasStationEndpoint.getAll
        return httpClient.request(endpoint: endpoint, responseModel: GetAllResponseDTO.self)
            .map { response in
                let gasStations = response.toDomain()
                self.updateGasStations(response: gasStations.mapToRealmObject())
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }

    private func updateGasStations(response: GetAllGasStationRealm) {
        DispatchQueue.main.async {
            do {
                try self.cacheService.update(object: response)
            } catch {
                print("||DEBUG|| updateGasStations - ERROR: \(error)")
            }
        }
    }

    func maxPrice(of fuelType: FuelType) -> Double {
        var maxPrice: Double = 0.0

        cacheService.fetch(GasStationRealm.self, predicate: nil, sorted: Sorted(key: fuelType.rawValue)) { stations in
            if let firstStation = stations.last {
                maxPrice = firstStation.dieselA
            }
        }

        return maxPrice
    }

    func minPrice(of fuelType: FuelType) -> Double {
        var minPrice: Double = 0.0

        cacheService.fetch(GasStationRealm.self, predicate: nil, sorted: Sorted(key: fuelType.rawValue)) { stations in
            if let firstStation = stations.first {
                minPrice = firstStation.dieselA
            }
        }

        return minPrice
    }
}
