//
//  User.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/9/23.
//

import Foundation

struct User {
    let fuelType: String
}

extension User {
    func mapToRealmObject() -> UserRealm {
        let model = UserRealm()
        model.fuelType = fuelType
        return model
    }

    static func mapFromRealmObject(_ user: UserRealm) -> User {
        return User(fuelType: user.fuelType)
    }
}
