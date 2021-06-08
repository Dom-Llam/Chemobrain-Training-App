//
//  AppNavigationManager.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/8/21.
//

import SwiftUI
import Combine

//enum myAppViews {
//    case Login
//    case Register
//    case HomeScreen
//    case Game1
//    case Game2
//    case Game3
//}
//
//final class MyAppEnvironmentData: ObservableObject {
//    @Published var currentPage: myAppViews? = .Login
//}

struct AppNavigationManager: View {
    var body: some View {
        NavigationView {
            Text("Wait")        }
    }
}

//struct PageOne: View {
//    @EnvironmentObject var env : MyAppEnvironmentData
//
//
//    var body: some View {
//        let navlink = NavigationLink(destination: PageTwo(),
//                       tag: .Register,
//                       selection: $env.currentPage,
//                       label: { EmptyView() })
//
//        return VStack {
//            Text("Page One").font(.largeTitle).padding()
//
//            navlink
//            .frame(width:0, height:0)
//
//            Button("Button") {
//                self.env.currentPage = .Login
//            }
//            .padding()
//            .border(Color.primary)
//
//        }
//    }
//
//}
//
//struct PageTwo: View {
//
//    @EnvironmentObject var env : MyAppEnvironmentData
//
//    var body: some View {
//        VStack {
//            Text("Page Two").font(.largeTitle).padding()
//
//            Text("Go Back")
//            .padding()
//            .border(Color.primary)
//            .onTapGesture {
//                self.env.currentPage = .Register
//            }
//        }.navigationBarBackButtonHidden(true)
//    }
//}
//
//struct AppNavigationManager_Previews: PreviewProvider {
//    static var previews: some View {
//        AppNavigationManager()
//    }
//}
