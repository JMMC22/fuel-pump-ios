//
//  DefaultUserRepository.swift
//  FuelPump
//
//  Created by José María Márquez Crespo on 19/9/23.
//

import Foundation
import Combine

final class DefaultUserRepository {

    /// Manager for local database operations.
    private let cacheService: DataManager

    /// Initializes the DefaultUserRepository with the specified data manager.
    /// - Parameter dataManager: The data manager for local database operations. Defaults to the default Realm data manager.
    init(dataManager: DataManager = RealmDataManager(RealmProvider.default)) {
        self.cacheService = dataManager
    }
}

extension DefaultUserRepository: UserRepository {

    /// Updates the fuel type for the user in the local database.
    ///
    /// - Parameter fuelType: The selected fuel type.
    /// - Returns: A publisher that emits a void value upon success or an error if the update fails.
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

    /// Retrieves the user model from the local database.
    ///
    /// - Returns: A publisher that emits an optional user or an error if the retrieval fails.
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
