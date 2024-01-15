//
//  GetUserUseCase.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 15/1/24.
//

import Foundation
import Combine

protocol GetUserUseCase {
    var userRepository: UserRepository { get set }
    func execute() -> AnyPublisher<User?, Error>
}

class DefaultGetUserUseCase: GetUserUseCase {

    var userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute() -> AnyPublisher<User?, Error> {
        return userRepository.getUser()
    }
}
