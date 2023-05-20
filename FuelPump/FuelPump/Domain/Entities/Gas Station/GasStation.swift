//
//  GasStation.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation
import RealmSwift

struct GasStation: Equatable, Hashable {
    let id: String
    let location: Location
    let address: String
    let city: String
    let province: String
    let company: String
    let icon: String
    let dieselA: String
    let dieselB: String
    let dieselPremium: String
    let gasoline95_E5: String
    let gasoline95_E10: String
    let gasoline95_E5_Premium: String
    let gasoline98_E5: String
    let gasoline98_E10: String

    static func companyToIcon(company: String) -> String {
        if let company = GasCompany(rawValue: company) {
            switch company {
            case .alcampo: return "alcampo-icon"
            case .bp: return "bp-icon"
            case .campsa: return "campsa-icon"
            case .cepsa: return "cepsa-icon"
            case .eroski: return "eroski-icon"
            case .galp: return "galp-icon"
            case .meroil: return "meroil-icon"
            case .pcan: return "pcan-icon"
            case .petronor: return "petronor-icon"
            case .repsol: return "repsol-icon"
            case .shell: return "shell-icon"
            default: return "default-icon"
            }
        } else {
            return "default-icon"
        }
    }
}

struct GetAllGasStation: Equatable {
    let date: String
    let gasStations: [GasStation]
}

extension GetAllGasStation {
    func mapToRealmObject() -> GetAllGasStationRealm {
        let model = GetAllGasStationRealm()
        model._date = date
        model.gasStations.append(objectsIn: gasStations.map({ $0.mapToRealmObject() }))
        return model
    }
    
    static func mapFromRealmObject(_ gasStation: GetAllGasStationRealm) -> GetAllGasStation {
        return GetAllGasStation(date: gasStation._date,
                                gasStations: gasStation.gasStations.map({ GasStation.mapFromRealmObject($0) }))
    }
}

extension GasStation {
    func mapToRealmObject() -> GasStationRealm {
        let model = GasStationRealm()
        model._id = id
        model.address = address
        model.city = city
        model.province = province
        model.company = company
        model.icon = GasStation.companyToIcon(company: company)
        return model
    }
    
    static func mapFromRealmObject(_ gasStation: GasStationRealm) -> GasStation {
        return GasStation(id: gasStation._id,
                          location: Location(latitude: gasStation.latitude,
                                             longitude: gasStation.longitude),
                          address: gasStation.address,
                          city: gasStation.city,
                          province: gasStation.province,
                          company: gasStation.company,
                          icon: gasStation.icon,
                          dieselA: gasStation.dieselA,
                          dieselB: gasStation.dieselB,
                          dieselPremium: gasStation.dieselPremium,
                          gasoline95_E5: gasStation.gasoline95_E5,
                          gasoline95_E10: gasStation.gasoline95_E10,
                          gasoline95_E5_Premium: gasStation.gasoline95_E5_Premium,
                          gasoline98_E5: gasStation.gasoline98_E5,
                          gasoline98_E10: gasStation.gasoline98_E10)
    }
}

extension GasStation {
    static let mockedData: [GasStation] = [GasStation(id: UUID().uuidString,
                                                      location: Location(latitude: "",
                                                                         longitude: ""),
                                                      address: "c/test",
                                                      city: "testCity",
                                                      province: "testProvince",
                                                      company: "companyTest",
                                                      icon: "default-icon",
                                                      dieselA: "",
                                                      dieselB: "",
                                                      dieselPremium: "",
                                                      gasoline95_E5: "",
                                                      gasoline95_E10: "",
                                                      gasoline95_E5_Premium: "",
                                                      gasoline98_E5: "",
                                                      gasoline98_E10: ""
                                                     ),
                                           GasStation(id: UUID().uuidString,
                                                      location: Location(latitude: "",
                                                                         longitude: ""),
                                                      address: "c/test2",
                                                      city: "testCity2",
                                                      province: "testProvince2",
                                                      company: "companyTest2",
                                                      icon: "default-icon",
                                                      dieselA: "",
                                                      dieselB: "",
                                                      dieselPremium: "",
                                                      gasoline95_E5: "",
                                                      gasoline95_E10: "",
                                                      gasoline95_E5_Premium: "",
                                                      gasoline98_E5: "",
                                                      gasoline98_E10: ""
                                                     ),
                                           GasStation(id: UUID().uuidString,
                                                      location: Location(latitude: "",
                                                                         longitude: ""),
                                                      address: "c/test3",
                                                      city: "testCity3",
                                                      province: "testProvince3",
                                                      company: "companyTest3",
                                                      icon: "default-icon",
                                                      dieselA: "",
                                                      dieselB: "",
                                                      dieselPremium: "",
                                                      gasoline95_E5: "",
                                                      gasoline95_E10: "",
                                                      gasoline95_E5_Premium: "",
                                                      gasoline98_E5: "",
                                                      gasoline98_E10: ""
                                                     )]
}
