//
//  GasStation.swift
//  FuelPump
//
//  Created by Jose Mari on 21/1/23.
//

import Foundation

struct GasStation: Equatable, Hashable {
    let address: String
    let city: String
    let province: String
    let company: String
    let icon: String
}

struct GetAllGasStation: Equatable {
    let date: String
    let gasStations: [GasStation]
}

extension GasStation {
    static let mockedData: [GasStation] = [GasStation(address: "c/test",
                                                      city: "testCity",
                                                      province: "testProvince",
                                                      company: "companyTest",
                                                      icon: "default-icon"),
                                           GasStation(address: "c/test2",
                                                      city: "testCity2",
                                                      province: "testProvince2",
                                                      company: "companyTest2",
                                                      icon: "default-icon"),
                                           GasStation(address: "c/test3",
                                                      city: "testCity3",
                                                      province: "testProvince3",
                                                      company: "companyTest3",
                                                      icon: "default-icon")]
}
