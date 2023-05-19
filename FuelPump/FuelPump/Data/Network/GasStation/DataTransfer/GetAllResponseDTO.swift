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
        let id: String
        let address: String
        let city: String
        let province: String
        let company: String
        
        private enum CodingKeys: String, CodingKey {
            case id = "IDEESS"
            case address = "Dirección"
            case city = "Municipio"
            case province = "Provincia"
            case company = "Rótulo"
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
        return .init(id: id,
                     address: address,
                     city: city,
                     province: province,
                     company: company,
                     icon: GasStation.companyToIcon(company: company))
    }
}
