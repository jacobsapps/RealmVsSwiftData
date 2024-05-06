//
//  RelamDatabase.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 09/04/2024.
//

import Foundation
import RealmSwift

protocol RealmDatabase<T>: Database 
where T: Object,
      Sorting == RealmSwift.SortDescriptor,
      Filtering == NSPredicate {
    func update(transaction: () -> Void) throws
}

extension RealmDatabase {
    
    var fileURL: URL? {
        Realm.Configuration.defaultConfiguration.fileURL
    }
    
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
    
    func update(transaction: () -> Void) throws {
        let realm = try Realm()
        try realm.write {
            transaction()
        }
    }
    
    func delete(_ item: T) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(item)
        }
    }
    
    func delete(_ items: [T]) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(items)
        }
    }
    
    func deleteAll() throws {
        let realm = try Realm()
        try realm.write {
            realm.deleteAll()
        }
    }
    
    /// Delete the existing schema if a migration is required.
    /// Don't use this in production!
    ///
    func eraseSchema() {
//        let config = Realm.Configuration(
//            schemaVersion: 1,
//            migrationBlock: { migration, oldSchemaVersion in
//                if (oldSchemaVersion < 1) { }
//            },
//            deleteRealmIfMigrationNeeded: true
//        )
//
//        Realm.Configuration.defaultConfiguration = config
//
//        do {
//            _ = try Realm()
//        } catch {
//            print(error)
//        }
    }
}
