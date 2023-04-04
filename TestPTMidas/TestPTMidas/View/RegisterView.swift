//
//  RegisterView.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var viewModel: MainScreenViewModel
//    @StateObject var viewModel = RegisterViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var isAdmin = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Register")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textInputAutocapitalization(.never)
            Toggle("Admin", isOn: $isAdmin)
                .font(.callout)
                .bold()
            Button {
                viewModel.addUser(email: email, password: password, role: isAdmin, username: username)
                self.presentationMode.wrappedValue.dismiss()
//                viewModel.updateUser()
            } label: {
                Text("Register")
                    .foregroundColor(.white)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height/20)
                    .background(.orange)
                    .cornerRadius(12)
            }
            Spacer()
            HStack{
                Text("Already have a account?")
                Text("Sign in")
                    .foregroundColor(.orange)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }

        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
