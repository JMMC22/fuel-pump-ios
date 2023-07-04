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

// MARK: - Mappings to Domain

extension GetAllResponseDTO {
    func toDomain() -> GetAllGasStation {
        return .init(date: date,
                     gasStations: gasStations.map { $0.toDomain() })
    }
}
