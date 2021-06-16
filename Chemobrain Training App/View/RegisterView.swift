//
//  RegisterView.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/16/21.
//

import SwiftUI

struct RegisterView: View {
    
    // To track page observable object
    @EnvironmentObject var env : MyAppEnvironmentData
    
    // For the Username and password TextField
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isEditingUser = false
    @State private var isEditingPassword = false
    @State private var invalid: Bool = false
    
    //Demographic information for user
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var phoneNumber: String = ""
    // To initially hide the demographic textfields
    
    
    var body: some View {
        
        List {
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
            }
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            TextField("First name", text: $firstName) { isEditing in
                self.isEditingUser = isEditing
            } onCommit: {
                // Add internal validation method here for realm
            }
                .padding()
            
            TextField("Last name", text: $lastName) { isEditing in
                self.isEditingUser = isEditing
            } onCommit: {
                // Add internal validation method here for realm
            }
                .padding()
            
            TextField("Phone number", text: $phoneNumber) { isEditing in
                self.isEditingUser = isEditing
            } onCommit: {
                // Add internal validation method here for realm
            }
                .padding()
            
            // Test to push through to home page screen from register through navlink
            NavigationLink(destination: HomeView(), label: {Text("Take me home") })
                .buttonStyle(MyButtonStyle(color: .blue))
                .foregroundColor(.blue)
                .navigationBarHidden(false)
        }
//        .aspectRatio(contentMode: .fit)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
    

    func validate() {
        if self.username == "" || self.password == "" {
            self.invalid = true
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
