//
//  LoginView.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import SwiftUI
import CoreData

struct LoginView: View {
//    @StateObject private var viewModel = LoginViewModel()
    @State private var email = ""
    @State private var password = ""
    @Binding var showLoginScreen:Bool
    @Binding var role:String
    @EnvironmentObject var viewModel: MainScreenViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing:20){
                Spacer()
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Please sign in to continue.")
                    .font(.subheadline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                Button {
                    viewModel.login(email: email, password: password){result in
                        role = viewModel.role
                        dismiss()
                    }
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height/20)
                        .background(.orange)
                        .cornerRadius(12)
                }
                Spacer()
                HStack{
                    Text("Don't have an account yet?")
                    NavigationLink(destination: RegisterView().environmentObject(viewModel)) {
                        Text("Sign up").foregroundColor(.orange)
                    }
                }
            }

        .padding()
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView(showLoginScreen: .constant(true), role: .constant("admin"), users: <#Binding<[UserViewModel]>#>)
//    }
//}
