//
//  RealmStudent.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 30/04/2024.
//

import Foundation
import RealmSwift

final class RealmStudent: Object {
    
    enum UserError: Error {
        case nameNotFound
    }
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var firstName: String
    @Persisted var surname: String
    @Persisted var age: Int
    @Persisted var grades: List<RealmGrade>

    override init() {
        super.init()
        guard let firstName = firstNames.randomElement(),
              let surname = surnames.randomElement() else {
            return
        }
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = Int.random(in: 11..<18)
    }
    
    init(firstName: String, surname: String, age: Int) {
        super.init()
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = age
    }
}

final class RealmSchool: Object {
   
    enum SchoolType: String, PersistableEnum {
        case comprehensive
        case grammar
        case `private`
        case religious
    }
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted(indexed: true) var name: String
    @Persisted var location: String
    @Persisted var type: SchoolType
    @Persisted var students: List<RealmStudent>
    
    init(id: UUID, name: String, location: String, type: SchoolType) {
        super.init()
        self.id = id
        self.name = name
        self.location = location
        self.type = type
    }
}

final class RealmGrade: Object {
    
    enum Subject: String, PersistableEnum {
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
    
    enum Grade: String, PersistableEnum {
        case aStar
        case a
        case b
        case c
        case d
        case e
        case f
        case u
    }
    
    enum ExamBoard: String, PersistableEnum {
        case aqa
        case edexcel
        case ocr
    }
    
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted(indexed: true) var subject: Subject
    @Persisted(indexed: true) var grade: Grade
    @Persisted var examBoard: ExamBoard
    @Persisted(originProperty: "grades") var student: LinkingObjects<RealmStudent>
    
    init(subject: Subject, examBoard: ExamBoard, grade: Grade) {
        self.init()
        self.subject = subject
        self.examBoard = examBoard
        self.grade = grade
    }
}
