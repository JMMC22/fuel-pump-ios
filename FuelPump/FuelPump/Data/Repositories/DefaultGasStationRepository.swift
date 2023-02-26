//
//  DefaultGasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import RealmSwift

final class DefaultGasStationRepository {

    private let cacheService: DataManager

    init(dataManager: DataManager = RealmDataManager(RealmProvider.default)) {
        self.cacheService = dataManager
    }
}

extension DefaultGasStationRepository: GasStationRepository, HTTPClient {

    func getAllGasStations() async throws -> GetAllGasStation {
        let endpoint = GasStationEndpoint.getAll
        return try await requestGasStationEndpoint(endpoint)
    }
    
    private func requestGasStationEndpoint(_ endpoint: Endpoint) async throws -> GetAllGasStation {
        do {
            let response = try await request(endpoint: endpoint,
                                         responseModel: GetAllResponseDTO.self)
            let domainResponse = response.toDomain()
            DispatchQueue.main.async {
                try? self.cacheService.update(object: domainResponse.mapToRealmObject())
            }
            return domainResponse
        } catch {
            throw error
        }
    }
}
