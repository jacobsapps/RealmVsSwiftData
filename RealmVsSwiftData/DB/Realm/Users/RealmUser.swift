//
//  RealmUser.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 09/04/2024.
//

import Foundation
import RealmSwift

final class RealmUser: Object, User {
    
    enum UserError: Error {
        case nameNotFound
    }
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var firstName: String
    @Persisted var surname: String
    @Persisted var age: Int
        
    override init() {
        super.init()
        guard let firstName = firstNames.randomElement(),
              let surname = surnames.randomElement() else {
            return
        }
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = Int.random(in: 0..<99)
    }
    
    init(firstName: String, surname: String, age: Int) {
        super.init()
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = age
    }
}
