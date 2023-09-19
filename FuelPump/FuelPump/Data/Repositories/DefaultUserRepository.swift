//
//  DefaultUserRepository.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/9/23.
//

import Foundation

final class DefaultUserRepository {

    private let cacheService: DataManager

    init(dataManager: DataManager = RealmDataManager(RealmProvider.default)) {
        self.cacheService = dataManager
    }
}

extension DefaultUserRepository: UserRepository {
    func updateUserFuelType(_ fuelType: FuelType) {
        // TODO: Update user property
    }
}
