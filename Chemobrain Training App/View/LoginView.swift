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
        
        NavigationView {
            VStack {
                GeometryReader { geo in
                    Image("SNAPLabBanner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width)
                }
                .frame(height: 200)
                
                VStack {
                    TextField("Enter user name", text: $username)
                        .padding()
                        .frame(width: 700, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    SecureField("Enter password", text: $password)
                        .padding()
                        .frame(width: 700, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    // Nav link to home page
                    NavigationLink(destination: HomeView(), label: {Text("Sign In") })
                        .buttonStyle(MyButtonStyle(color: .blue))
                        .foregroundColor(.blue)
                        .navigationBarTitle("Sign in")

                    // Nav link to register screen
                    NavigationLink(destination: RegisterView(), label: {Text("New user?") })
                        .foregroundColor(.blue)
                }
                
                .padding()
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
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
