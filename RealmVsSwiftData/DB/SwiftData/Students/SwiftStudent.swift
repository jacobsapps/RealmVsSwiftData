//
//  SwiftStudent.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 30/04/2024.
//

import Foundation
import SwiftData

@Model
final class SwiftStudent: User {
    
    enum UserError: Error {
        case nameNotFound
    }
    
    @Attribute(.unique) let id: UUID
    var firstName: String
    var surname: String
    var age: Int
    var school: SwiftSchool?
    @Relationship(deleteRule: .cascade, inverse: \SwiftGrade.student) var grades: [SwiftGrade]

    
    init() throws {
        guard let firstName = firstNames.randomElement(),
              let surname = surnames.randomElement() else {
            throw UserError.nameNotFound
        }
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = Int.random(in: 11..<18)
        self.grades = SwiftGrade.randomSelection()
    }
    
    init(firstName: String, surname: String, age: Int, grades: [SwiftGrade]) {
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = age
        self.grades = grades
    }
}

@Model
final class SwiftSchool {
   
    enum SchoolType: Codable {
        case comprehensive
        case grammar
        case `private`
        case religious
    }
    
    @Attribute(.unique) let id: UUID
    var name: String
    var location: String
    var type: SchoolType
    @Relationship(deleteRule: .nullify, inverse: \SwiftStudent.school) var students: [SwiftStudent]
    
    init(id: UUID, name: String, location: String, type: SchoolType, students: [SwiftStudent] = []) {
        self.id = id
        self.name = name
        self.location = location
        self.type = type
        self.students = students 
    }
}

@Model
final class SwiftGrade {
    
    enum Subject: Codable {
        case maths
        case english
        case litereature
        case physics
        case chemistry
        case biology
        case history
        case geography
        case french
        case german
        case music
        case art
        case physicalEducation
        case religiousStudies
    }
    
    enum Grade: Codable {
        case aStar
        case a
        case b
        case c
        case d
        case e
        case f
        case u
    }
    
    enum ExamBoard: Codable {
        case aqa
        case edexcel
        case ocr
    }
    
    var subject: Subject
    var grade: Grade
    var examBoard: ExamBoard
    var student: SwiftStudent?
    
    init(subject: Subject, examBoard: ExamBoard, grade: Grade) {
        self.subject = subject
        self.examBoard = examBoard
        self.grade = grade
    }
    
    static func randomSelection() -> [SwiftGrade] {
        []
    }
}
