//
//  User.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/9/23.
//

import Foundation

struct User {
    let id: String
    let fuelType: FuelType
}

extension User {
    func mapToRealmObject() -> UserRealm {
        let model = UserRealm()
        model._id = id
        model.fuelType = fuelType.rawValue
        return model
    }

    static func mapFromRealmObject(_ user: UserRealm) -> User {
        return User(id: user._id, fuelType: FuelType(rawValue: user.fuelType) ?? .dieselA)
    }
}
