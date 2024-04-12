//
//  RelamDB.swift
//  NoSwiftDataNoUI
//
//  Created by Jacob Bartlett on 09/04/2024.
//

import Foundation
import RealmSwift

protocol RealmDatabase<T>: Database 
where T: Object,
      Sorting == RealmSwift.SortDescriptor,
      Filtering == NSPredicate {}

extension RealmDatabase {
    
    func create(_ item: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(item)
        }
    }
    
    func create(_ items: [T]) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(items)
        }
    }
    
    func read(predicate: Filtering?, sortBy sortDescriptors: [Sorting]) throws -> [T] {
        let realm = try Realm()
        if let predicate {
            return Array(realm
                .objects(T.self)
                .filter(predicate)
                .sorted(by: sortDescriptors))
            
        } else {
            return Array(realm
                .objects(T.self)
                .sorted(by: sortDescriptors))
        }
    }
    
    func update(_ item: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.add(item, update: .modified)
        }
    }
    
    func delete(_ item: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(item)
        }
    }
    
    func deleteAll() throws {
        let realm = try Realm()
        try realm.write {
            realm.deleteAll()
        }
    }
}
