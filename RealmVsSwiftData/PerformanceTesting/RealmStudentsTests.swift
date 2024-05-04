//
//  RealmStudentsTests.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 02/05/2024.
//

import Foundation

func realmStudentsPerformanceTests(with studentsCount: Int = 10_000) {

    announce("Realm: \(formatNumberWithCommas(studentsCount)) Complex Objects")
    
    let db = RealmStudentDB()
    try! db.deleteAll()
    var students = [RealmStudent]()
    
    logExecutionTime("Student instantiation") {
        let schoolCount = 100
        let firstSchool = RealmSchool(name: "Falconwood College", location: "Falconwood", type: .comprehensive)
        let schools = [firstSchool] + (1..<schoolCount).compactMap { _ in RealmSchool() }
        let studentsPerSchool = studentsCount / schoolCount
        for school in schools {
            students.append(contentsOf: (0..<studentsPerSchool).compactMap { _ in
                RealmStudent(school: school)
            })
        }
    }
    
    logExecutionTime("Create students") {
        try! db.create(students)
    }
    
    logExecutionTime("Read students with A* in Physics") {
        let predicate = NSPredicate(format: "ANY grades.subject == %@ AND ANY grades.grade == %@", RealmGrade.Subject.physics.rawValue, RealmGrade.Grade.aStar.rawValue)
        let studentsWithAStarInPhysics = try! db.read(predicate: predicate)
        print("\(studentsWithAStarInPhysics.count) students with an A* in Physics")
    }
    
    logExecutionTime("Fail the cheating Maths students") {
        let predicate = NSPredicate(format: "school.name == %@ AND ANY grades.subject == %@", "Falconwood College", "Maths")
        let studentsWhoCheatedAtMaths = try! db.read(predicate: predicate)
        try! db.update {
            let mathsGrades = studentsWhoCheatedAtMaths
                .flatMap { $0.grades }
                .filter { $0.subject == RealmGrade.Subject.maths }
            for grade in mathsGrades {
                grade.grade = .f
            }
        }
    }
    
    measureSize(of: db)
    
    logExecutionTime("Delete all students") {
        try! db.deleteAll()
    }
}
