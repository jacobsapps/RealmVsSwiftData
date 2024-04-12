//
//  ContentViewModel.swift
//  NoSwiftDataNoUI
//
//  Created by Jacob Bartlett on 02/04/2024.
//

import Foundation
import RealmSwift

@Observable
final class ContentViewModel {
    
    enum DB {
        case swiftData
        case realm
    }
    
    var users: [any User] = []
    private let swiftDB: SwiftUserDB
    private let realmDB: RealmUserDB
    
    init(db: DB) {
        swiftDB = try! SwiftUserDB()
        realmDB = RealmUserDB()
        
        realmPerformanceTest()
        swiftPerformanceTest()
    }
}
