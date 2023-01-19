//
//  DataManager.swift
//  FuelPump
//
//  Created by Jose Mari on 19/1/23.
//

import Foundation
import RealmSwift

protocol DataManager {
    func create<T: Storable>(_ model: T.Type, completion: @escaping ((T) -> Void)) throws
    func save(object: Storable) throws
    func update(object: Storable) throws
    func delete(object: Storable) throws
    func deleteAll<T: Storable>(_ model: T.Type) throws
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))
}
public protocol Storable {}
extension Object: Storable {}

public struct Sorted {
    var key: String
    var ascending: Bool = true
}
