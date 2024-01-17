//
//  GasStationDetailsViewModel.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 17/1/24.
//

import Foundation

class GasStationDetailsViewModel: ObservableObject {

    @Published var companyName: String = ""
    @Published var companyIcon: String = ""
    @Published var address: String = ""
    @Published var schedule: String = ""
    @Published var fuelPrices: [FuelType: Double] = [:]
    @Published var addressURL: URL?

    private let station: GasStation

    init(station: GasStation) {
        self.station = station
        self.companyName = GasCompany(rawValue: station.company)?.rawValue ?? ""
        self.companyIcon = GasStation.companyToIcon(company: station.company)
        self.address = station.address
        self.schedule = station.schedule
        self.fuelPrices = station.prices
        self.addressURL = URL(string: "maps://?saddr=&daddr=\(station.location.latitude),\(station.location.longitude)")
    }
}
