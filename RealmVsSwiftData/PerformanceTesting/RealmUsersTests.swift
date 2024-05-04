//
//  RealmUsersTests.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 02/05/2024.
//

import Foundation

func realmUsersPerformanceTests(with usersCount: Int = 100_000) {
    
    announce("Realm: \(formatNumberWithCommas(usersCount)) Simple Objects")
    
    let db = RealmUserDB()
    try! db.deleteAll()
    
    var users = [RealmUser]()
    logExecutionTime("User instantiation") {
        users = (0..<usersCount).compactMap { _ in RealmUser() }
    }
    
    logExecutionTime("Create users") {
        try! db.create(users)
    }
    
    logExecutionTime("Fetch users named `Jane` in age order") {
        let predicate = NSPredicate(format: "firstName == %@", "Jane")
        let janes = try! db.read(predicate: predicate, sortBy: .init(keyPath: \RealmUser.age))
        print("\(janes.count) users named Jane")
    }
    
    logExecutionTime("Rename users named `Jane` to `Wendy`") {
        let predicate = NSPredicate(format: "firstName == %@", "Jane")
        let janes = try! db.read(predicate: predicate, sortBy: .init(keyPath: \RealmUser.age))
        try! db.update {
            for jane in janes {
                jane.firstName = "Wendy"
            }
        }
        print("\(janes.count) users renamed to `Wendy`")
    }
    
    measureSize(of: db)
    
    logExecutionTime("Delete all users") {
        try! db.deleteAll()
    }
}
