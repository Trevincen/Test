//
//  CoreDataManagingClass.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 04/04/23.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManagingClass {
    static let instance = CoreDataManagingClass()
    
    let container:NSPersistentContainer
    let context:NSManagedObjectContext
    var error:NSError? = nil
    let count:Int = 0
    
    init(){
        container = NSPersistentContainer(name: "TestPTMidas")
        container.loadPersistentStores { description, Error in
            if let Error = Error {
                print(Error)
            }else{
                print("success load coredata")
            }
        }
        context = container.viewContext
    }
    
    func saveUsers(){
        do{
            try context.save()
            print("success")
        }catch let error{
            print(error)
        }
    }
}
