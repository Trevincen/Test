////
////  Persistence.swift
////  TestPTMidas
////
////  Created by Trevincen Tambunan on 04/04/23.
////
//
//import Foundation
//
//import CoreData
//
//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    let container: NSPersistentContainer
//
//    init() {
//        container = NSPersistentContainer(name: "User")
//
//        container.loadPersistentStores{ (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolve Error: \(error)")
//            }
//        }
//    }
//}
