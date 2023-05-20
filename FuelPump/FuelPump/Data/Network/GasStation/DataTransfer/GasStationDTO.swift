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
        return .init(id: id,
                     location: Location(latitude: latitude ?? "",
                                        longitude: longitude ?? ""),
                     address: address ?? "",
                     city: city ?? "",
                     province: province ?? "",
                     company: company ?? "",
                     icon: GasStation.companyToIcon(company: company ?? ""),
                     dieselA: dieselA ?? "",
                     dieselB: dieselB ?? "",
                     dieselPremium: dieselPremium ?? "",
                     gasoline95_E5: gasoline95_E5 ?? "",
                     gasoline95_E10: gasoline95_E10 ?? "",
                     gasoline95_E5_Premium: gasoline95_E5_Premium ?? "",
                     gasoline98_E5: gasoline98_E5 ?? "",
                     gasoline98_E10: gasoline98_E10 ?? "")
    }
}
