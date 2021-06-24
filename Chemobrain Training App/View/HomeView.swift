//
//  HomeView.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/16/21.
//

import SwiftUI

struct HomeView: View {
    
    // To track page observable object
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            Text("We did it!")
            
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("SignOut")
                    .foregroundColor(Color.blue)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
