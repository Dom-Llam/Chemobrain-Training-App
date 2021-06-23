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
                    
                    TextField("First name", text: $firstName)
                        .padding()
                        .frame(width: 700, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    TextField("Last name", text: $lastName)
                        .padding()
                        .frame(width: 700, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    TextField("Phone number", text: $phoneNumber)
                        .padding()
                        .frame(width: 700, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    // Test to push through to home page screen from register through navlink
                    NavigationLink(destination: HomeView(), label: {Text("Sign Up") })
                        .buttonStyle(MyButtonStyle(color: .blue))
                        .foregroundColor(.blue)
                        .navigationBarHidden(false)
                }
                .padding()
                Spacer()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
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
