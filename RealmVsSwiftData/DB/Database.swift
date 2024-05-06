//
//  Database.swift
//  RealmVsSwiftData
//
//  Created by Jacob Bartlett on 02/04/2024.
//

import Foundation

protocol Database<T> {
    associatedtype T
    associatedtype Sorting
    associatedtype Filtering
    var fileURL: URL? { get }
    func create(_ item: T) throws
    func create(_ items: [T]) throws
    func read(predicate: Filtering?, sortBy sortDescriptors: [Sorting]) throws -> [T]
    func delete(_ item: T) throws
    func delete(_ items: [T]) throws
    func deleteAll() throws
}

extension Database {
    
    func read(sortBy sortDescriptors: Sorting...) throws -> [T] {
        try read(predicate: nil, sortBy: sortDescriptors)
    }
    
    func read(predicate: Filtering?, sortBy sortDescriptors: Sorting...) throws -> [T] {
        try read(predicate: predicate, sortBy: sortDescriptors)
    }
}
