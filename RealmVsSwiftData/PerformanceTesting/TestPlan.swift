//
//  TestPlan.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 10/04/2024.
//

import Foundation

// Benchmarking: put these into an excel sheet, with a log number of items increasing

// Query Testing:
// 1. Fetch users w/ a certain first name
// 2. Fetch students at named school
// 3. Fetch all students who got an A* in Physics

func realmPerformanceTest() {
    
    print("Realm")
    let db = RealmUserDB()
    try! db.deleteAll()
    let users = (0..<100_000).compactMap { _ in RealmUser() }
    
    logExecutionTime("Write em") {
        try! db.create(users)
    }
    
    logExecutionTime("Read all") {
        _ = try! db.read(sortBy: .init(keyPath: \RealmUser.surname), .init(keyPath: \RealmUser.firstName))
    }
    
    logExecutionTime("Get Jane") {
        let predicate = NSPredicate(format: "firstName == %@", "Jane")
        let janes = try! db.read(predicate: predicate, sortBy: .init(keyPath: \RealmUser.age))
        print("\(janes.count) Janes")
    }
    
    logExecutionTime("Delete em") {
        try! db.deleteAll()
    }
    
    print()
}

func swiftPerformanceTest() {
    
    print("Swift Data")
    let db = try! SwiftUserDB()
    try! db.deleteAll()
    let users = (0..<100_000).compactMap { _ in try! SwiftUser() }
    
    logExecutionTime("Write em") {
        try! db.create(users)
    }
    
    logExecutionTime("Read all") {
        _ = try! db.read(sortBy: SortDescriptor(\.surname), SortDescriptor(\.firstName))
    }
    
    logExecutionTime("Get Jane") {
        let predicate = #Predicate<SwiftUser> { $0.firstName == "Jane" }
        let janes = try! db.read(predicate: predicate, sortBy: SortDescriptor(\.age))
        print("\(janes.count) Janes")
    }
    
    logExecutionTime("Delete em") {
        try! db.deleteAll()
    }
    
    print()
}

func logExecutionTime(_ title: String, _ execute: () -> Void) {
    let start = CFAbsoluteTimeGetCurrent()
    execute()
    let diff = CFAbsoluteTimeGetCurrent() - start
    print("\(title): \(diff)s")
}
