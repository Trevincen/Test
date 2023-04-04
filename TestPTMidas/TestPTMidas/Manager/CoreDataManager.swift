//
//  CoreDataManager.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func getUserById(id: NSManagedObjectID) -> Users? {
        
        do {
            return try viewContext.existingObject(with: id) as? Users
        } catch {
            return nil
        }
        
    }
    
    func deleteUser(user: Users) {
        
        viewContext.delete(user)
        save()
        
    }
    
    func getAllUser() -> [Users] {
        
        let request: NSFetchRequest<Users> = Users.fetchRequest()
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "User")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
}
