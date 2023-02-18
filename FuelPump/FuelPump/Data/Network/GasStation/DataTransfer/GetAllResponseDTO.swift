//
//  GetAllResponseDTO.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation

struct GetAllResponseDTO: Decodable {
    let date: String
    let note: String
    let gasStations: [GasStationDTO]
    let result: String

    private enum CodingKeys: String, CodingKey {
        case date = "Fecha"
        case note = "Nota"
        case gasStations = "ListaEESSPrecio"
        case result = "ResultadoConsulta"
    }
}

extension GetAllResponseDTO {
    struct GasStationDTO: Decodable {
        let address: String
        
        private enum CodingKeys: String, CodingKey {
            case address = "Dirección"
        }
    }
}

// MARK: - Mappings to Domain

extension GetAllResponseDTO {
    func toDomain() -> GetAllGasStation {
        return .init(date: date,
                     gasStations: gasStations.map { $0.toDomain() })
    }
}

extension GetAllResponseDTO.GasStationDTO {
    func toDomain() -> GasStation {
        return .init(address: address)
    }
}
