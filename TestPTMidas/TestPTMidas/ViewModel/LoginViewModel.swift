//
//  LoginViewModel.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import Foundation
import CoreData

//class LoginViewModel:ObservableObject {
//    private let viewContext = PersistenceController.shared.viewContext
//    @Published var role:String = ""
//    
//    func login(email:String, password:String, completion:@escaping((Bool) -> ())){
//        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
//        do {
//            let users = try viewContext.fetch(fetchRequest)
//            guard let user = users.first else {
//                // TODO: Display error message
//                print("no user")
//                return
//            }
//            if user.password == password {
//                print("LOGIN")
//                self.role = user.role ?? "no Role"
//                UserDefaults.standard.string(forKey: "role")
//                UserDefaults.standard.set(user.role, forKey: "role")
//                UserDefaults.standard.bool(forKey: "showLoginScreen")
//                UserDefaults.standard.set(false, forKey: "showLoginScreen")
//                completion(true)
//            } else {
//                print("Pass Salah")
//                completion(false)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//}
