//
//  EnvObject.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import Foundation

class EnvObject: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = true
}
