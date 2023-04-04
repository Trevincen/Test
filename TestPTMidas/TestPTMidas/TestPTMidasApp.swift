//
//  TestPTMidasApp.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 03/04/23.
//

import SwiftUI

@main
struct TestPTMidasApp: App {
//    let persistenceController = PersistenceController.shared
    @StateObject var viewModel: MainScreenViewModel = MainScreenViewModel()

    var body: some Scene {
        WindowGroup {
//            SplashView().environmentObject(viewModel)
            SplashView()
                .environmentObject(viewModel)
        }
    }
}
