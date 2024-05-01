//
//  User.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 02/04/2024.
//

import Foundation
import SwiftData

protocol User: Identifiable {
    var id: UUID { get }
    var firstName: String { get }
    var surname: String { get }
    var age: Int { get }
}

@Model
final class SwiftUser: User {
    
    enum UserError: Error {
        case nameNotFound
    }
    
    @Attribute(.unique) let id: UUID
    let firstName: String
    let surname: String
    let age: Int
    
    init() throws {
        guard let firstName = firstNames.randomElement(),
              let surname = surnames.randomElement() else {
            throw UserError.nameNotFound
        }
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = Int.random(in: 0..<99)
    }
    
    init(firstName: String, surname: String, age: Int) {
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = age
    }
}
