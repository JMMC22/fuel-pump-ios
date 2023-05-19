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

    func getAllGasStations() -> AnyPublisher<GetAllGasStation, Error> {
        let endpoint = GasStationEndpoint.getAll
        return httpClient.request(endpoint: endpoint, responseModel: GetAllResponseDTO.self)
            .map { response in
                let gasStations = response.toDomain()
                self.updateGasStations(response: gasStations.mapToRealmObject())
                return gasStations
            }
            .eraseToAnyPublisher()
    }

    private func updateGasStations(response: GetAllGasStationRealm) {
        DispatchQueue.main.async {
            do {
                try self.cacheService.update(object: response)
            } catch {
                print("----- Error updateGasStations: \(error)")
            }
        }
    }
}
