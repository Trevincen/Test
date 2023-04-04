//
//  MainScreenViewModel.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import Foundation
import CoreData
import SwiftUI

class MainScreenViewModel: ObservableObject {
//    private let viewContext = PersistenceController.shared.viewContext
    let manger = CoreDataManagingClass.instance
    let request = NSFetchRequest<Users>(entityName: "Users")
    @Published var users:[Users] = []
    @Published var albums:[Album] = []
    @Published var role:String
    @Published var showLoginScreen:Bool
    @Published var isLoading = false
    var page = 1
    var totalPages = 1
    @Published var count = 50
   
   

    init(){
        
        self.role = UserDefaults.standard.string(forKey: "role") ?? "kosong"
        if UserDefaults.standard.object(forKey: "showLoginScreen") == nil {
            self.showLoginScreen = true
            print("The key is empty")
        } else {
            print(UserDefaults.standard.bool(forKey: "showLoginScreen"))
            self.showLoginScreen = UserDefaults.standard.bool(forKey: "showLoginScreen")
            print("The key has a value")
        }
        fetchAlbum()
        fetchUsers()
        
    }
    
    func fetchUsers(){
        do {
            self.users = try manger.context.fetch(request)
            print("success load user")
            print(self.users[0].email)
        }catch let error{
            print(error)
        }
    }
    
    func addUser(email: String, password: String, role: Bool, username:String){
        let newUser = Users(context: manger.context)
        newUser.id = UUID().uuidString
        newUser.email = email
        newUser.password = password
        newUser.role = role == false ? "user" : "admin"
        newUser.username = username
        print(newUser)
        saveData()
            
    }
    
    func deleteUser(indexset: IndexSet){
        guard let index = indexset.first else {return}
        let entity = users[index]
        manger.container.viewContext.delete(entity)
        saveData()
    }
    
    func updateUser(){
        do{
            try manger.container.viewContext.save()
        }catch{
            manger.container.viewContext.rollback()
        }
    }
    
    
    func fetchAlbum() {
//        print("total data :\(self.albums.count)")
        guard !isLoading else { return }
        guard page <= totalPages else { return }
        isLoading = true
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos?_limit=\(count)")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let data = data, let decodedResponse = try? JSONDecoder().decode([Album].self, from: data) {
                    self.albums = decodedResponse
                    self.albums.sort {
                        $0.albumId < $1.albumId
                    }
                    self.count+=50
                }
            }
        }.resume()
    }
    
        func login(email:String, password:String, completion:@escaping((Bool) -> ())){
            let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "email == %@", email)
            do {
                let users = try manger.container.viewContext.fetch(fetchRequest)
                guard let user = users.first else {
                    // TODO: Display error message
                    print("no user")
                    return
                }
                if user.password == password {
                    print("LOGIN")
                    self.role = user.role ?? "no Role"
                    UserDefaults.standard.string(forKey: "role")
                    UserDefaults.standard.set(user.role, forKey: "role")
                    UserDefaults.standard.bool(forKey: "showLoginScreen")
                    UserDefaults.standard.set(false, forKey: "showLoginScreen")
                    completion(true)
                } else {
                    print("Pass Salah")
                    completion(false)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    
    func saveData(){
        users.removeAll()
        self.manger.saveUsers()
        self.fetchUsers()
    }
    
    struct PaginationData {
        let totalPages: Int
        
        init(headers: [AnyHashable: Any]) {
            let totalHeader = headers["X-Total-Count"] as? String ?? ""
            self.totalPages = Int(totalHeader) ?? 1
        }
    }
    
    var hasMoreData: Bool {
        !isLoading && page <= totalPages
    }
}
