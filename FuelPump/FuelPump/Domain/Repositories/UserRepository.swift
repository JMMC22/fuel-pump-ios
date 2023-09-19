//
//  UserRepository.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/9/23.
//

import Foundation

protocol UserRepository {
    func updateUserFuelType(_ fuelType: FuelType)
}
