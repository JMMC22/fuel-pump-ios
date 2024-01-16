//
//  UpdateUserFuelTypeUseCase.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 12/9/23.
//

import Foundation
import Combine

protocol UpdateUserFuelTypeUseCase {
    var userRepository: UserRepository { get set }
    func execute(_ fuelType: FuelType) -> AnyPublisher<Void, Error>
}

class DefaultUpdateUserFuelTypeUseCase: UpdateUserFuelTypeUseCase {

    var userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(_ fuelType: FuelType) -> AnyPublisher<Void, Error> {
        return userRepository.updateUserFuelType(fuelType)
    }
}
