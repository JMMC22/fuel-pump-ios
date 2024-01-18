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

    func getGasStations(latitude: Double, longitude: Double, limit: Int)  -> GasStationsResult {
        var allGasStations: [GetAllGasStation] = []

        self.cacheService.fetch(GetAllGasStationRealm.self,
                                predicate: nil,
                                sorted: nil) { response in
            allGasStations = response.map { GetAllGasStation.mapFromRealmObject($0) }
        }

        guard let gasStations = allGasStations.first?.gasStations else {
            return GasStationsResult(gasStations: [], maxPrice: 0.0, minPrice: 0.0)
        }

        guard !latitude.isZero, !longitude.isZero else {
            let gasStations = Array(gasStations.prefix(limit))
            return GasStationsResult(gasStations: gasStations, maxPrice: 0.0, minPrice: 0.0)
        }
        
        let userLocation = Location(latitude: String(latitude), longitude: String(longitude))

        let sortedGasStations = gasStations.sorted {
            let distance1 = calculateHaversineDistance(from: $0.location, to: userLocation)
            let distance2 = calculateHaversineDistance(from: $1.location, to: userLocation)

            return distance1 < distance2
        }

        return GasStationsResult(gasStations: Array(sortedGasStations.prefix(limit)), maxPrice: 0.0, minPrice: 0.0)
    }

    func calculateHaversineDistance(from source: Location, to destination: Location) -> Double {
        let sourceLocation = CLLocation(latitude: Double(source.latitude) ?? 0.0, longitude: Double(source.longitude) ?? 0.0)
        let destinationLocation = CLLocation(latitude: Double(destination.latitude) ?? 0.0, longitude: Double(destination.longitude) ?? 0.0)

        return sourceLocation.distance(from: destinationLocation)
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
