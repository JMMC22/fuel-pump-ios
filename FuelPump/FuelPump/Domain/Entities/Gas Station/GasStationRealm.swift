//
//  GasStationRealm.swift
//  FuelPump
//
//  Created by Jose Mari on 25/2/23.
//

import RealmSwift

class GetAllGasStationRealm: Object {
    @Persisted(primaryKey: true) var _date: String
    @Persisted var gasStations: List<GasStationRealm>
}

class GasStationRealm: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var latitude: String
    @Persisted var longitude: String
    @Persisted var address: String
    @Persisted var schedule: String
    @Persisted var city: String
    @Persisted var province: String
    @Persisted var company: String
    @Persisted var icon: String
    @Persisted var dieselA: Double
    @Persisted var dieselB: Double
    @Persisted var dieselPremium: Double
    @Persisted var gasoline95_E5: Double
    @Persisted var gasoline95_E10: Double
    @Persisted var gasoline95_E5_Premium: Double
    @Persisted var gasoline98_E5: Double
    @Persisted var gasoline98_E10: Double
}
