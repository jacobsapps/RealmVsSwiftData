//
//  SwiftUserDB.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 02/04/2024.
//

import Foundation
import SwiftData

final class SwiftUserDB: SwiftDatabase {    
    
    typealias T = SwiftUser
    
    let container: ModelContainer
    
    /// Use an in-memory store to store non-persistent data when unit testing
    ///
    init(useInMemoryStore: Bool = false) throws {
        let configuration = ModelConfiguration(for: SwiftUser.self, isStoredInMemoryOnly: useInMemoryStore)
        container = try ModelContainer(for: SwiftUser.self, configurations: configuration)
    }
}
