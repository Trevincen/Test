//
//  AuthViewModel.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 04/04/23.
//

import Foundation
import CoreData

class AuthViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.container.viewContext
    
    var isAuthenticated: Bool {
        return UserDefaults.standard.bool(forKey: "isAuthenticated")
    }
    
    func login(email: String, password: String) -> Bool {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        do {
            let results = try viewContext.fetch(request)
            if results.count > 0 {
                // User authenticated successfully
                UserDefaults.standard.set(true, forKey: "isAuthenticated")
                return true
            } else {
                // Invalid credentials
                return false
            }
        } catch {
            print("Error fetching user: \(error.localizedDescription)")
            return false
        }
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "isAuthenticated")
    }
}
