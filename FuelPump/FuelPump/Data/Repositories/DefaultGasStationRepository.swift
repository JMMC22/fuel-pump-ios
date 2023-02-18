//
//  DefaultGasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation

final class DefaultGasStationRepository {

    // private let cacheService: DataManager

    init() {
        // self.cacheService = cacheService
    }
}

extension DefaultGasStationRepository: GasStationRepository, HTTPClient {

    func getAllGasStations() async throws -> GetAllGasStation {
        let endpoint = GasStationEndpoint.getAll

        do {
            let response = try await request(endpoint: endpoint,
                                         responseModel: GetAllResponseDTO.self)
            return response.toDomain()
        } catch {
            throw error
        }
    }
}
