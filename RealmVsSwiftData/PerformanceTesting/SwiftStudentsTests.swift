//
//  SwiftStudentsTests.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 02/05/2024.
//

import Foundation

func swiftStudentsPerformanceTests(with studentsCount: Int = 10_000) {
    
    announce("SwiftData: \(formatNumberWithCommas(studentsCount)) Complex Objects")
        
    let db = try! SwiftStudentDB()
    try! db.deleteAll()
    var students = [SwiftStudent]()
    
    logExecutionTime("Student instantiation") {
        let schoolCount = 100
        let firstSchool = SwiftSchool(name: "Falconwood College", location: "Falconwood", type: .comprehensive)
        let schools = [firstSchool] + (1..<schoolCount).compactMap { _ in try? SwiftSchool() }
        let studentsPerSchool = studentsCount / schoolCount
        for school in schools {
            students.append(contentsOf: (0..<studentsPerSchool).compactMap { _ in
                try? SwiftStudent(school: school)
            })
        }
    }
    
    logExecutionTime("Create students") {
        try! db.create(students)
    }
    
    logExecutionTime("Read students with A* in Physics") {
        let physics = SwiftGrade.Subject.physics.rawValue
        let aStarGrade = SwiftGrade.Grade.aStar.rawValue
        let predicate = #Predicate<SwiftStudent> { student in
            student.grades.contains(where: {
                $0.subject == physics
                && $0.grade == aStarGrade
            })
        }
        let studentsWithAStarInPhysics = try! db.read(predicate: predicate)
        print("\(studentsWithAStarInPhysics.count) students with an A* in Physics")
    }
    
    logExecutionTime("Fail the cheating Maths students") {
        let maths = SwiftGrade.Subject.maths.rawValue
        let predicate = #Predicate<SwiftStudent> { student in
            (student.school?.name == "Falconwood College")
            && (student.grades.contains(where: { $0.subject == maths }))
        }
        let studentsWhoCheatedAtMaths = try! db.read(predicate: predicate)
        let mathsGrades = studentsWhoCheatedAtMaths
            .flatMap { $0.grades }
            .filter { $0.subject == maths }
        for grade in mathsGrades {
            grade.grade = SwiftGrade.Grade.f.rawValue
        }
        try! db.update(studentsWhoCheatedAtMaths)
    }
    
    measureSize(of: db)
    
    logExecutionTime("Delete all students") {
        try! db.deleteAll()
    }
}
