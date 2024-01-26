//
//  DefaultGasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation
import Combine
import CoreLocation
import RealmSwift

enum ErrorGasStationRepository: Error {
    case noGasStationsFound
    case realmNotAvailable
}

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
    
    func getNearestGasStations(by fuel: FuelType, latitude: Double, longitude: Double, limit: Int = 10) -> AnyPublisher<GasStationsResult, Error> {
        guard let realm = RealmProvider.default else {
            return Fail(error: ErrorGasStationRepository.realmNotAvailable).eraseToAnyPublisher()
        }
        
        let results = realm.objects(GetAllGasStationRealm.self)
        
        return results.collectionPublisher
            .tryMap { response in
                guard let lastResult = response.last else {
                    throw ErrorGasStationRepository.noGasStationsFound
                }
                
                let result = GetAllGasStation.mapFromRealmObject(lastResult)
                return self.handleGetAllGasStation(result.gasStations, fuel: fuel, latitude: latitude, longitude: longitude)
            }
            .eraseToAnyPublisher()
    }
    
    private func handleGetAllGasStation(_ stations: [GasStation], fuel: FuelType, latitude: Double, longitude: Double, limit: Int = 10) -> GasStationsResult {
        guard stations.isEmpty == false else {
            return GasStationsResult(gasStations: [], maxPrice: 0.0, minPrice: 0.0, date: "")
        }

        guard !latitude.isZero, !longitude.isZero else {
            let gasStations = Array(stations.prefix(limit))
            let maxPrice = maxPrice(of: fuel, stations: gasStations)
            let minPrice = minPrice(of: fuel, stations: gasStations)
            return GasStationsResult(gasStations: gasStations, maxPrice: maxPrice, minPrice: minPrice, date: "")
        }

        let userLocation = Location(latitude: String(latitude), longitude: String(longitude))

        let sortedGasStations = stations.sorted {
            let distance1 = userLocation.calculateDistance(to: $0.location)
            let distance2 = userLocation.calculateDistance(to: $1.location)

            return distance1 < distance2
        }

        let gasStations = Array(sortedGasStations.prefix(limit))
        let maxPrice = maxPrice(of: fuel, stations: gasStations)
        let minPrice = minPrice(of: fuel, stations: gasStations)
        return GasStationsResult(gasStations: gasStations, maxPrice: maxPrice, minPrice: minPrice, date: "")
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

// MARK: - Logic functions
extension DefaultGasStationRepository {
    func maxPrice(of fuelType: FuelType, stations: [GasStation]) -> Double {
        return stations.max(by: { $0.getFavouriteFuelPrice(fuelType) <
                                  $1.getFavouriteFuelPrice(fuelType)})?.getFavouriteFuelPrice(fuelType) ?? 0
    }

    func minPrice(of fuelType: FuelType, stations: [GasStation]) -> Double {
        return stations.max(by: { $0.getFavouriteFuelPrice(fuelType) >
                                  $1.getFavouriteFuelPrice(fuelType)})?.getFavouriteFuelPrice(fuelType) ?? 0
    }
}
