//
//  GasStationDTO.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 20/5/23.
//

import Foundation

struct GasStationDTO: Decodable {
    let id: String
    let latitude: String?
    let longitude: String?
    let schedule: String?
    let address: String?
    let city: String?
    let province: String?
    let company: String?
    let dieselA: String?
    let dieselB: String?
    let dieselPremium: String?
    let gasoline95_E5: String?
    let gasoline95_E10: String?
    let gasoline95_E5_Premium: String?
    let gasoline98_E5: String?
    let gasoline98_E10: String?

    private enum CodingKeys: String, CodingKey {
        case id = "IDEESS"
        case latitude = "Latitud"
        case longitude = "Longitud (WGS84)"
        case schedule = "Horario"
        case address = "Dirección"
        case city = "Municipio"
        case province = "Provincia"
        case company = "Rótulo"
        case dieselA = "Precio Gasoleo A"
        case dieselB = "Precio Gasoleo B"
        case dieselPremium = "Precio Gasoleo Premium"
        case gasoline95_E5 = "Precio Gasolina 95 E5"
        case gasoline95_E10 = "Precio Gasolina 95 E10"
        case gasoline95_E5_Premium = "Precio Gasolina 95 E5 Premium"
        case gasoline98_E5 = "Precio Gasolina 98 E5"
        case gasoline98_E10 = "Precio Gasolina 98 E10"
    }
}

extension GasStationDTO {
    func toDomain() -> GasStation {

        let dieselAValue = dieselA?.formattedDouble ?? 0.0
        let dieselBValue = dieselB?.formattedDouble ?? 0.0
        let dieselPremiumValue = dieselPremium?.formattedDouble ?? 0.0
        let gasoline95_E5Value = gasoline95_E5?.formattedDouble ?? 0.0
        let gasoline95_E10Value = gasoline95_E10?.formattedDouble ?? 0.0
        let gasoline95_E5_PremiumValue = gasoline95_E5_Premium?.formattedDouble ?? 0.0
        let gasoline98_E5Value = gasoline98_E5?.formattedDouble ?? 0.0
        let gasoline98_E10Value = gasoline98_E10?.formattedDouble ?? 0.0

        return .init(id: id,
                     location: Location(latitude: latitude ?? "",
                                        longitude: longitude ?? ""),
                     address: address ?? "",
                     schedule: schedule ?? "",
                     city: city ?? "",
                     province: province ?? "",
                     company: company ?? "",
                     icon: GasStation.companyToIcon(company: company ?? ""),
                     dieselA: dieselAValue,
                     dieselB: dieselBValue,
                     dieselPremium: dieselPremiumValue,
                     gasoline95_E5: gasoline95_E5Value,
                     gasoline95_E10: gasoline95_E10Value,
                     gasoline95_E5_Premium: gasoline95_E5_PremiumValue,
                     gasoline98_E5: gasoline98_E5Value,
                     gasoline98_E10: gasoline98_E10Value)
    }
}
