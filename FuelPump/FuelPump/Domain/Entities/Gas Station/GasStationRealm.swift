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
    @Persisted var address: String
    @Persisted var city: String
    @Persisted var province: String
    @Persisted var company: String
    @Persisted var icon: String
}
