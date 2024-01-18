//
//  DefaultGasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation
import Combine
import CoreLocation

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

    func getGasStations(latitude: Double, longitude: Double, fuel: FuelType, limit: Int = 10)  -> GasStationsResult {
        var allGasStations: [GasStation] = []

        let nonZeroPredicate = NSPredicate(format: "\(fuel.description) != 0")

        self.cacheService.fetch(GasStationRealm.self,
                                predicate: nonZeroPredicate,
                                sorted: nil) { response in
            allGasStations = response.map { GasStation.mapFromRealmObject($0) }
        }

        guard allGasStations.isEmpty == false else {
            return GasStationsResult(gasStations: [], maxPrice: 0.0, minPrice: 0.0)
        }

        let maxPrice = maxPrice(of: fuel)
        let minPrice = minPrice(of: fuel)

        guard !latitude.isZero, !longitude.isZero else {
            let gasStations = Array(allGasStations.prefix(limit))
            return GasStationsResult(gasStations: gasStations, maxPrice: maxPrice, minPrice: minPrice)
        }

        let userLocation = Location(latitude: String(latitude), longitude: String(longitude))

        let sortedGasStations = allGasStations.sorted {
            let distance1 = userLocation.calculateDistance(to: $0.location)
            let distance2 = userLocation.calculateDistance(to: $1.location)

            return distance1 < distance2
        }

        return GasStationsResult(gasStations: Array(sortedGasStations.prefix(limit)), maxPrice: maxPrice, minPrice: minPrice)
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

        cacheService.fetch(GasStationRealm.self, predicate: nil, sorted: Sorted(key: fuelType.description)) { stations in
            if let lastStation = stations.last {
                maxPrice = GasStation.mapFromRealmObject(lastStation).getFavouriteFuelPrice(fuelType)
            }
        }

        return maxPrice
    }

    func minPrice(of fuelType: FuelType) -> Double {
        var minPrice: Double = 0.0

        let nonZeroPredicate = NSPredicate(format: "\(fuelType.description) != 0")

        cacheService.fetch(GasStationRealm.self, predicate: nonZeroPredicate, sorted: Sorted(key: fuelType.description)) { stations in
            if let firstStation = stations.first {
                minPrice = GasStation.mapFromRealmObject(firstStation).getFavouriteFuelPrice(fuelType)
            }
        }

        return minPrice
    }
}

// MARK: - Network Requests
extension DefaultGasStationRepository {
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
}
