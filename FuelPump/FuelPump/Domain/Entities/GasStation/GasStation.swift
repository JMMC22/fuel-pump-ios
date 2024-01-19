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
    let schedule: String
    let city: String
    let province: String
    let company: String
    let icon: String
    let dieselA: Double
    let dieselB: Double
    let dieselPremium: Double
    let gasoline95_E5: Double
    let gasoline95_E10: Double
    let gasoline95_E5_Premium: Double
    let gasoline98_E5: Double
    let gasoline98_E10: Double

    var prices: [FuelType: Double] {
        [
            .dieselA: dieselA,
            .dieselB: dieselB,
            .dieselPremium: dieselPremium,
            .gasoline95_E5: gasoline95_E5,
            .gasoline95_E10: gasoline95_E10,
            .gasoline95_E5_Premium: gasoline95_E5_Premium,
            .gasoline98_E5: gasoline98_E5,
            .gasoline98_E10: gasoline98_E10
        ]
    }
}

extension GasStation {
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
    
    func getFavouriteFuelPrice(_ fuel: FuelType) -> Double {
        switch fuel {
        case .dieselA:
            return dieselA
        case .dieselB:
            return dieselB
        case .dieselPremium:
            return dieselPremium
        case .gasoline95_E5:
            return gasoline95_E5
        case .gasoline95_E10:
            return gasoline95_E10
        case .gasoline95_E5_Premium:
            return gasoline95_E5_Premium
        case .gasoline98_E5:
            return gasoline98_E5
        case .gasoline98_E10:
            return gasoline98_E10
        }
    }

    func getFuelRange(_ fuel: FuelType, maxPrice: Double, minPrice: Double) -> FuelRange {
        let totalRange = maxPrice - minPrice
        let range = totalRange / 3
        let price = getFavouriteFuelPrice(fuel)

        if price < (minPrice + range) {
            return .low
        } else if price > (maxPrice - range) {
            return .high
        } else {
            return .middle
        }
    }
}

extension GasStation {
    func mapToRealmObject() -> GasStationRealm {
        let model = GasStationRealm()
        model._id = id
        model.address = address
        model.schedule = schedule
        model.city = city
        model.latitude = location.latitude.replacingOccurrences(of: ",", with: ".")
        model.longitude = location.longitude.replacingOccurrences(of: ",", with: ".")
        model.province = province
        model.company = company
        model.icon = GasStation.companyToIcon(company: company)
        model.dieselA = dieselA
        model.dieselB = dieselB
        model.dieselPremium = dieselPremium
        model.gasoline95_E5 = gasoline95_E5
        model.gasoline95_E10 = gasoline95_E10
        model.gasoline95_E5_Premium = gasoline95_E5_Premium
        model.gasoline98_E5 = gasoline98_E5
        model.gasoline98_E10 = gasoline98_E10
        return model
    }
    
    static func mapFromRealmObject(_ gasStation: GasStationRealm) -> GasStation {
        return GasStation(id: gasStation._id,
                          location: Location(latitude: gasStation.latitude,
                                             longitude: gasStation.longitude),
                          address: gasStation.address,
                          schedule: gasStation.schedule,
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
                                                      schedule: "",
                                                      city: "testCity",
                                                      province: "testProvince",
                                                      company: "companyTest",
                                                      icon: "default-icon",
                                                      dieselA: 1.1,
                                                      dieselB: 0.0,
                                                      dieselPremium: 0.0,
                                                      gasoline95_E5: 0.0,
                                                      gasoline95_E10: 0.0,
                                                      gasoline95_E5_Premium: 0.0,
                                                      gasoline98_E5: 0.0,
                                                      gasoline98_E10: 0.0
                                                     ),
                                           GasStation(id: UUID().uuidString,
                                                      location: Location(latitude: "",
                                                                         longitude: ""),
                                                      address: "c/test2",
                                                      schedule: "",
                                                      city: "testCity2",
                                                      province: "testProvince2",
                                                      company: "companyTest2",
                                                      icon: "default-icon",
                                                      dieselA: 1.4,
                                                      dieselB: 0.0,
                                                      dieselPremium: 0.0,
                                                      gasoline95_E5: 0.0,
                                                      gasoline95_E10: 0.0,
                                                      gasoline95_E5_Premium: 0.0,
                                                      gasoline98_E5: 0.0,
                                                      gasoline98_E10: 0.0
                                                     ),
                                           GasStation(id: UUID().uuidString,
                                                      location: Location(latitude: "",
                                                                         longitude: ""),
                                                      address: "c/test3",
                                                      schedule: "",
                                                      city: "testCity3",
                                                      province: "testProvince3",
                                                      company: "companyTest3",
                                                      icon: "default-icon",
                                                      dieselA: 1.7,
                                                      dieselB: 0.0,
                                                      dieselPremium: 0.0,
                                                      gasoline95_E5: 0.0,
                                                      gasoline95_E10: 0.0,
                                                      gasoline95_E5_Premium: 0.0,
                                                      gasoline98_E5: 0.0,
                                                      gasoline98_E10: 0.0
                                                     )]
}
