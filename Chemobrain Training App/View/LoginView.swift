//
//  LoginView.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/16/21.
//

import SwiftUI

//MARK: - Login View

struct LoginView: View {
    
    
    // The environmentObject that should update the current presented screen
    @EnvironmentObject var env : MyAppEnvironmentData
    
    // For the Username and password TextField
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isEditingUser = false
    @State private var isEditingPassword = false
    @State private var invalid: Bool = false
    
    
    var body: some View {
        // To create a constant for the navigationLink
//        let navLink = NavigationLink("New user?", destination: RegistrationView())
        
        return List {
            Spacer()
            
            GeometryReader { geo in
                Image("SNAPLabBanner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
            }
            .frame(height: 200)
            
            
            TextField("Enter user name", text: $username) { isEditing in
                self.isEditingUser = isEditing
            } onCommit: {
                // Add internal validation method here for realm
                // validate(name: username)
            }
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
           
            
            TextField("Enter password", text: $password) { isEditing in
                self.isEditingPassword = isEditing
            } onCommit: {
                // Add internal validation method here for realm
                // validate(name: username)
            }
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            // Testing new navLink
//            navLink.frame(width: 10, height: 10)

            // Nav link to home page
            NavigationLink(destination: HomeView(), label: {Text("Take me home") })
                .buttonStyle(MyButtonStyle(color: .blue))
                .foregroundColor(.blue)
                .navigationBarHidden(false)
            
            // Nav link to register screen
            NavigationLink(destination: RegisterView(), label: {Text("New user punk?") })
                .buttonStyle(MyButtonStyle(color: .blue))
                .foregroundColor(.blue)
                .navigationBarTitle("Sign in")
                .navigationBarHidden(false)
        }
//        .aspectRatio(contentMode: .fit)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .navigationBarTitle("Login")
    }
    
    func validate() {
        if self.username == "" || self.password == "" {
            self.invalid = true
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
