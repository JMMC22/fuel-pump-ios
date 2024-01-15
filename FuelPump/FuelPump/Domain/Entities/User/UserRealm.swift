//
//  UserRealm.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/9/23.
//

import Foundation
import RealmSwift

class UserRealm: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var fuelType: String
}
