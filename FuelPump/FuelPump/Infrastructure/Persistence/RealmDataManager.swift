//
//  RealmDataManager.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import Foundation
import RealmSwift

class RealmDataManager {

    private let realm: Realm?

    init(_ realm: Realm?) {
        self.realm = realm
    }
}

extension RealmDataManager: DataManager {
    func create<T>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            throw RealmError.nilOrNotRealmSpecificModel
        }
        try realm.write {
            let newObject = realm.create(model, value: [], update: .error) as! T
            completion(newObject)
        }
    }

    func save(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.nilOrNotRealmSpecificModel
        }

        try realm.write {
            realm.add(object)
        }
    }

    func saveAll(objects: [Storable]) throws {
        guard let realm = realm, let objects = objects as? [Object] else {
            throw RealmError.nilOrNotRealmSpecificModel
        }

        for object in objects {
            try realm.write {
                realm.add(object)
            }
        }
    }

    func update(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.nilOrNotRealmSpecificModel
        }

        try realm.write {
            realm.add(object, update: .modified)
        }
    }

    func delete(object: Storable) throws {
        guard let realm = realm, let object = object as? Object else {
            throw RealmError.nilOrNotRealmSpecificModel
        }

        try realm.write {
            realm.delete(object)
        }
    }

    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else {
            throw RealmError.nilOrNotRealmSpecificModel
        }

        try realm.write {
            let objects = realm.objects(model)
            for object in objects {
                realm.delete(object)
            }
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        guard let realm = realm, let model = model as? Object.Type else { return }
        var objects = realm.objects(model)

        if let predicate = predicate {
            objects = objects.filter(predicate)
        }

        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }

        completion(objects.compactMap { $0 as? T })
    }
}

enum RealmError: Error {
    case nilOrNotRealmSpecificModel
}
