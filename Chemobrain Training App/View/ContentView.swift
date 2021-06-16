//
//  ContentView.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/3/21.
//

import SwiftUI
import Combine

//Class and enum to hold state values for active screen
enum MyAppPage {
    case LoginView
    case RegisterView
    case HomeView
}

final class MyAppEnvironmentData: ObservableObject {
    @Published var currentPage : MyAppPage? = .LoginView
}


//MARK: - Original Navigation View

struct ContentView: View {
    
    //EnvironmentObject for navigation view
    @EnvironmentObject var env : MyAppEnvironmentData
    
    var body: some View {
        
        NavigationView {
            LoginView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

            ContentView().environmentObject(MyAppEnvironmentData())
         
    }
}
