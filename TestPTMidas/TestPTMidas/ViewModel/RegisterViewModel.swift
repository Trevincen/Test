//
//  RegisterViewModel.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import Foundation

//class RegisterViewModel:ObservableObject {
//    private let viewContext = PersistenceController.shared.viewContext
//    
//    func Register(email: String, password: String, role: Bool, username:String, completion:@escaping((String) -> ())){
//        let user = User(context: viewContext)
//        user.id = UUID().uuidString
//        user.email = email
//        user.password = password
//        user.role = role == false ? "user" : "admin"
//        user.username = username
//        do {
//            try viewContext.save()
//            print("Success")
//            completion("success")
//        }catch {
//            print("Error saving")
//            completion("error")
//        }
//    }
//}
