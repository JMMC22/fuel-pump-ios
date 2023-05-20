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
    @Persisted var city: String
    @Persisted var province: String
    @Persisted var company: String
    @Persisted var icon: String
    @Persisted var dieselA: String
    @Persisted var dieselB: String
    @Persisted var dieselPremium: String
    @Persisted var gasoline95_E5: String
    @Persisted var gasoline95_E10: String
    @Persisted var gasoline95_E5_Premium: String
    @Persisted var gasoline98_E5: String
    @Persisted var gasoline98_E10: String
}
