//
//  ContentView.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
struct LoginView: View {
    
    // For the Username and password TextField
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isEditingUser = false
    @State private var isEditingPassword = false
    @State private var invalid: Bool = false
    
    
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
                // validate(name: username)
            }
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            
            NavigationLink(destination: RegistrationView(), label: {Text("New user?") })
                .buttonStyle(MyButtonStyle(color: .blue))
                .foregroundColor(.blue)
                .navigationBarTitle("Already a user? Sign in")
                .navigationBarHidden(true)

            
            
                        
            
            
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

struct RegistrationView: View {
    
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
                // validate(name: username)
            }
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
            TextField("First name", text: $firstName) { isEditing in
                self.isEditingUser = isEditing
            } onCommit: {
                // Add internal validation method here for realm
                // validate(name: username)
            }
                .padding()
            
            TextField("Last name", text: $lastName) { isEditing in
                self.isEditingUser = isEditing
            } onCommit: {
                // Add internal validation method here for realm
                // validate(name: username)
            }
                .padding()
            
            TextField("Phone number", text: $phoneNumber) { isEditing in
                self.isEditingUser = isEditing
            } onCommit: {
                // Add internal validation method here for realm
                // validate(name: username)
            }
                .padding()
            
            Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Register")
            }
            
            
            
            
        }
//        .aspectRatio(contentMode: .fit)
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .navigationBarTitle("Register New User")
    }
    
    func validate() {
        if self.username == "" || self.password == "" {
            self.invalid = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

            ContentView()
         
    }
}
