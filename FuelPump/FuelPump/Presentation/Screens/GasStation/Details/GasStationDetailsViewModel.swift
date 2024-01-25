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
    @Published var distance: String = ""

    private let station: GasStation
    private let locationManager: LocationManager

    init(station: GasStation, locationManager: LocationManager = .shared) {
        self.station = station
        self.locationManager = locationManager
        self.companyName = GasCompany(rawValue: station.company)?.rawValue ?? ""
        self.companyIcon = GasStation.companyToIcon(company: station.company)
        self.address = station.address
        self.schedule = station.schedule
        self.fuelPrices = station.prices
        let distance = locationManager.getDistance(to: station.location)
        self.distance = distance < 1000 ? "\(distance) m" : String(format: "%.1f km", (distance / 1000))
    }
}

extension GasStationDetailsViewModel {
    func getMapAppURL(_ app: MapApp) -> URL? {
        return URL(string: app.appUrl(location: Location(latitude: station.location.latitude,
                                                         longitude: station.location.longitude)))
    }
}
