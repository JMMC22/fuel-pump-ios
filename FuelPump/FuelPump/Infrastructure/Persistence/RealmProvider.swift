//
//  RealmProvider.swift
//  FuelPump
//
//  Created by Jose Mari on 25/2/23.
//

import RealmSwift

struct RealmProvider {

    let configuration: Realm.Configuration

    internal init(config: Realm.Configuration) {
        configuration = config
    }

    var realm: Realm? {
        do {
            print("User Realm User file location: \(configuration.fileURL!.path)")
            return try Realm(configuration: configuration)
        } catch {
            print("RealmProvider: \(error)")
            return nil
        }
    }

    private static let defaultConfig = Realm.Configuration()
    
    public static var `default`: Realm? = {
        return RealmProvider(config: RealmProvider.defaultConfig).realm
    }()
}
