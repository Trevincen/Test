//
//  SplashView.swift
//  TestPTMidas
//
//  Created by Trevincen Tambunan on 04/04/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive:Bool = false
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [
//        SortDescriptor(\.email),
//        SortDescriptor(\.role)
//    ]) var notes: FetchedResults<User>
    @EnvironmentObject var viewModel:MainScreenViewModel
    
    var body: some View {
        ZStack{
            if self.isActive {
                MainScreenView()
                    .environmentObject(viewModel)
            }else{
//                Rectangle()
//                    .background(.white)
                Image("MidasLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
            }
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+2.5){
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
