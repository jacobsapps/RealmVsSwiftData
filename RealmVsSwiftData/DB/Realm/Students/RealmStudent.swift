//
//  RealmStudent.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 30/04/2024.
//

import Foundation
import RealmSwift

final class RealmStudent: Object {
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var firstName: String
    @Persisted var surname: String
    @Persisted var age: Int
    @Persisted var school: RealmSchool?
    @Persisted var grades: List<RealmGrade>
    
    override init() {
        super.init()
    }
    
    init?(school: RealmSchool) {
        guard let firstName = firstNames.randomElement(),
              let surname = surnames.randomElement() else {
            return nil
        }
        super.init()
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = Int.random(in: 11..<18)
        self.grades = RealmGrade.randomGrades()
        school.students.append(self)
    }
    
    init(id: UUID = UUID(), firstName: String, surname: String, age: Int) {
        super.init()
        self.id = UUID()
        self.firstName = firstName
        self.surname = surname
        self.age = age
    }
}

final class RealmSchool: Object {
    
    enum SchoolType: String, PersistableEnum, CaseIterable {
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
    
    override init() {
        super.init()
        guard let name = schoolNames.randomElement(),
              let location = schoolLocations.randomElement(),
              let type = SchoolType.allCases.randomElement() else {
            return
        }
        self.id = UUID()
        self.name = name
        self.location = location
        self.type = type
    }
    
    init(id: UUID = UUID(), name: String, location: String, type: SchoolType) {
        super.init()
        self.id = id
        self.name = name
        self.location = location
        self.type = type
    }
}

final class RealmGrade: Object {
    
    enum Subject: String, PersistableEnum, CaseIterable {
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
    
    enum Grade: String, PersistableEnum, CaseIterable {
        case aStar
        case a
        case b
        case c
        case d
        case e
        case f
        case u
    }
    
    enum ExamBoard: String, PersistableEnum, CaseIterable {
        case aqa
        case edexcel
        case ocr
    }
    
    @Persisted(primaryKey: true) var id: UUID
    @Persisted(indexed: true) var subject: Subject
    @Persisted(indexed: true) var grade: Grade
    @Persisted var examBoard: ExamBoard
    @Persisted(originProperty: "grades") var student: LinkingObjects<RealmStudent>
    
    override init() {
        super.init()
        guard let subject = Subject.allCases.randomElement(),
              let grade = Grade.allCases.randomElement(),
              let examBoard = ExamBoard.allCases.randomElement() else {
            return
        }
        self.id = UUID()
        self.subject = subject
        self.grade = grade
        self.examBoard = examBoard
    }
    
    init(id: UUID = UUID(), subject: Subject, examBoard: ExamBoard, grade: Grade) {
        super.init()
        self.id = id
        self.subject = subject
        self.examBoard = examBoard
        self.grade = grade
    }
    
    static func randomGrades() -> List<RealmGrade> {
        let max = Int.random(in: 1..<7)
        let grades = List<RealmGrade>()
        for _ in 0...max {
            grades.append(RealmGrade())
        }
        return grades
    }
}
