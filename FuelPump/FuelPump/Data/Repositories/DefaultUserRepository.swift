//
//  DefaultUserRepository.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/9/23.
//

import Foundation
import Combine

final class DefaultUserRepository {

    private let cacheService: DataManager

    init(dataManager: DataManager = RealmDataManager(RealmProvider.default)) {
        self.cacheService = dataManager
    }
}

extension DefaultUserRepository: UserRepository {
    func updateUserFuelType(_ fuelType: FuelType) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            let user = User(id: UUID().uuidString, fuelType: fuelType).mapToRealmObject()
            do {
                try self.cacheService.update(object: user)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }

    func getUser() -> AnyPublisher<User?, Error> {
        return Future<User?, Error> { promise in
            self.cacheService.fetch(UserRealm.self, predicate: nil, sorted: nil) { realmUsers in
                guard let realmUser = realmUsers.first else {
                    promise(.success(nil))
                    return
                }
                let user = User.mapFromRealmObject(realmUser)
                promise(.success(user))
            }
        }
        .eraseToAnyPublisher()
    }
}
