//
//  EditView.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 04/04/23.
//

import SwiftUI

struct EditView: View {
    @ObservedObject var user:Users
    @EnvironmentObject var vm:MainScreenViewModel
    @State var emailTextField:String = ""
    var body: some View {
        Text("Edit user")
        TextField("Email", text: Binding($user.email, emailTextField))
        Button {
            vm.updateUser()
            vm.fetchUsers()
        } label: {
            Text("Update")
        }

    }
}

extension Binding {
    init(_ source: Binding<Value?>, _ defaultValue:Value) {
        if source.wrappedValue == nil {
            source.wrappedValue = defaultValue
        }
        self.init(source)!
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView()
//    }
//}
