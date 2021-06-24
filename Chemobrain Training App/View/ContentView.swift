//
//  ContentView.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/3/21.
//

import SwiftUI
import FirebaseAuth


//MARK: - Original Navigation View

struct ContentView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        
        NavigationView {
            if viewModel.isSignedIn {
                HomeView()
                
            } else {
                LoginView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

            ContentView()
         
    }
}
