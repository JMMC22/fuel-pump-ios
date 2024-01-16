//
//  UserRepository.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/9/23.
//

import Foundation
import Combine

protocol UserRepository {
    func updateUserFuelType(_ fuelType: FuelType) -> AnyPublisher<Void, Error>
    func getUser() -> AnyPublisher<User?, Error>
}
