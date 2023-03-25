//
//  DefaultGasStationRepository.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

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

    func getAllGasStations() -> AnyPublisher<GetAllGasStation, Error> {
        let endpoint = GasStationEndpoint.getAll
        return httpClient.request(endpoint: endpoint, responseModel: GetAllResponseDTO.self)
            .map { response in
                return response.toDomain()
            }
            .eraseToAnyPublisher()
    }
}
