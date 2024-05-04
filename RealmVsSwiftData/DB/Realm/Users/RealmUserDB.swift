//
//  RealmUserDB.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 09/04/2024.
//

import Foundation
import RealmSwift

final class RealmUserDB: RealmDatabase {

    typealias T = RealmUser

    init() {
        // Allow easy schema migrations - don't use this in production!
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
