//
//  ContentView.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import SwiftUI
import CoreData

struct MainScreenView: View {
    //    @StateObject var viewModel = MainScreenViewModel()
    @EnvironmentObject var viewModel:MainScreenViewModel
    
    var body: some View{
        NavigationView {
            VStack{
                if viewModel.role == "admin" {
                    AdminView(showLoginScreen: $viewModel.showLoginScreen)
                        .navigationTitle("All User")
                        .navigationBarTitleDisplayMode(.inline)
                        .environmentObject(viewModel)
                }else{
                    UserView(showLoginScreen: $viewModel.showLoginScreen)
                        .navigationTitle("Album")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        UserDefaults.standard.set(true, forKey: "showLoginScreen")
                        viewModel.showLoginScreen = true
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                    }
                    
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.showLoginScreen, content: {
            LoginView(showLoginScreen: $viewModel.showLoginScreen, role: $viewModel.role)
                .environmentObject(viewModel)
        })
        .onChange(of: viewModel.showLoginScreen) { newValue in
            viewModel.fetchUsers()
        }
    }
    
}

struct AdminView: View {
    //    @StateObject var viewModel = MainScreenViewModel()
//    @Binding var users:[Users]
    @Binding var showLoginScreen:Bool
    @State var selectedID:Int = 1
    @State private var showingOptions = false
    @State var showEdit = false
    @EnvironmentObject var viewModel:MainScreenViewModel
    var body: some View{
        ScrollView {
            VStack {
                List {
                    ForEach(viewModel.users) { user in
                        VStack(alignment:.leading){
                            Text("Email : \(user.email ?? "No Email")")
                            Text("Role : \(user.role ?? "No Role")")
                            Text(user.id ?? "No ID")
                            Divider()
                        }
                        .onTapGesture {
//                            self.selectedID = i
                            self.showingOptions = true
                        }
                        
                        
                    }
                }
            }
            .confirmationDialog("Select Action", isPresented: $showingOptions) {
                Button {
                    //update
                    
                } label: {
                    Text("Update")
                }
                
                Button {
                    //delete
                    //                    viewModel.deleteUser(user: users[0])
                } label: {
                    Text("Delete")
                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct UserView: View {
    @StateObject var viewModel = MainScreenViewModel()
    @Binding var showLoginScreen: Bool
    
    var body: some View {
        List(0..<viewModel.albums.count,id: \.self) { i in
            if i == viewModel.albums.count-1{
                cellView(album: viewModel.albums[i], isLast: true, viewModel: self.viewModel)
                    .listRowSeparator(.hidden)
            }else{
                cellView(album: viewModel.albums[i], isLast: false, viewModel: self.viewModel)
                    .listRowSeparator(.hidden)
            }
            Divider()
        }
        
        .scrollContentBackground(.hidden)
    }
    
    func getContentHeight() -> CGFloat {
        let itemCount = CGFloat(viewModel.albums.count)
        let rows = ceil(itemCount / 2) // Assuming 2 items per row
        let rowHeight: CGFloat = 200 // Assuming each row is 200 points high
        let spacing: CGFloat = 10 // Vertical spacing between rows
        let contentHeight = rows * rowHeight + (rows - 1) * spacing
        return contentHeight
    }
}

struct cellView : View{
    var album:Album
    var isLast:Bool
    @ObservedObject var viewModel : MainScreenViewModel
    
    
    var body: some View{
        
        HStack{
            AsyncImage(url: URL(string: album.url)!) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                    //                        .frame(width: 100, height: 100)
                case .failure(let error):
                    Text("Error loading image")
                        .font(.callout)
                @unknown default:
                    fatalError()
                }
            }
            .frame(width: 100, height: 100)
            VStack(alignment:.leading){
                
                Text("\(album.id)")
                if self.isLast {
                    Text(album.title)
                        .font(.title3)
                        .onAppear{
                            self.viewModel.fetchAlbum()
                        }
                    
                }else{
                    Text(album.title)
                        .font(.title3)
                }
            }
        }
        
        
        
        
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
