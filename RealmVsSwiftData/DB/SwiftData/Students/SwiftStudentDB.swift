//
//  SwiftStudentDB.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 30/04/2024.
//

import Foundation
import SwiftData

final class SwiftStudentDB: SwiftDatabase {
    
    typealias T = SwiftStudent
    
    let container: ModelContainer
    
    /// Use an in-memory store to store non-persistent data when unit testing
    ///
    init(useInMemoryStore: Bool = false) throws {
        let configuration = ModelConfiguration(for: SwiftStudent.self, isStoredInMemoryOnly: useInMemoryStore)
        container = try ModelContainer(for: SwiftStudent.self, configurations: configuration)
    }
}
