//
//  SwiftStudent.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 30/04/2024.
//

import Foundation
import SwiftData

enum SwiftDataError: Error {
    case dataNotFound
}

@Model
final class SwiftStudent: User {
    
    @Attribute(.unique) let id: UUID
    var firstName: String
    var surname: String
    var age: Int
    @Relationship(deleteRule: .cascade, inverse: \SwiftSchool.students) var school: SwiftSchool?
    @Relationship(deleteRule: .cascade, inverse: \SwiftGrade.student) var grades: [SwiftGrade]
    
    init(school: SwiftSchool) throws {
        guard let firstName = firstNames.randomElement(),
              let surname = surnames.randomElement() else {
            throw SwiftDataError.dataNotFound
        }
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = Int.random(in: 11..<18)
        self.school = school
        self.grades = SwiftGrade.randomGrades()
    }
    
    init(id: UUID = UUID(), firstName: String, surname: String, age: Int, grades: [SwiftGrade]) {
        self.id = id
        self.firstName = firstName
        self.surname = surname
        self.age = age
        self.grades = grades
    }
}

@Model
final class SwiftSchool {
   
    enum SchoolError: Error {
        case dataNotFound
    }
    
    enum SchoolType: Codable, CaseIterable {
        case comprehensive
        case grammar
        case `private`
        case religious
    }
    
    @Attribute(.unique) let id: UUID
    var name: String
    var location: String
    var type: SchoolType
    var students: [SwiftStudent]
    
    init() throws {
        guard let name = schoolNames.randomElement(),
              let location = schoolLocations.randomElement(),
              let type = SchoolType.allCases.randomElement() else {
            throw SwiftDataError.dataNotFound
        }
        self.id = UUID()
        self.name = name
        self.location = location
        self.type = type
        self.students = []
    }
    
    init(id: UUID = UUID(), name: String, location: String, type: SchoolType, students: [SwiftStudent] = []) {
        self.id = id
        self.name = name
        self.location = location
        self.type = type
        self.students = students 
    }
}

@Model
final class SwiftGrade {
    
    enum Subject: String, CaseIterable {
        case maths
        case english
        case literature
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
    
    enum Grade: String, CaseIterable {
        case aStar
        case a
        case b
        case c
        case d
        case e
        case f
        case u
    }
    
    enum ExamBoard: String, CaseIterable {
        case aqa
        case edexcel
        case ocr
    }
    
    @Attribute(.unique) let id: UUID
    // SwiftData macros and predicates don't behave well with enums
    var subject: String
    var grade: String
    var examBoard: String
    var student: SwiftStudent?
    
    init() throws {
        guard let subject = Subject.allCases.randomElement(),
              let grade = Grade.allCases.randomElement(),
              let examBoard = ExamBoard.allCases.randomElement() else {
            throw SwiftDataError.dataNotFound
        }
        self.id = UUID()
        self.subject = subject.rawValue
        self.grade = grade.rawValue
        self.examBoard = examBoard.rawValue
    }
    
    init(id: UUID = UUID(), subject: Subject, examBoard: ExamBoard, grade: Grade) {
        self.id = id
        self.subject = subject.rawValue
        self.examBoard = examBoard.rawValue
        self.grade = grade.rawValue
    }
    
    static func randomGrades() -> [SwiftGrade] {
        let max = Int.random(in: 1..<7)
        return (0...max).compactMap { _ in
            try? SwiftGrade()
        }
    }
}
