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
    @EnvironmentObject var viewModel: AppViewModel

    // For the Username and password TextField
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isEditingUser = false
    @State private var isEditingPassword = false
    @State private var invalid: Bool = false
    
    
    var body: some View {
       

            VStack {
                GeometryReader { geo in
                    Image("SNAPLabBanner")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geo.size.width)
                }
                .frame(height: 200)
                
                VStack {
                    TextField("Enter email", text: $email)
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
                    
                    //Switch to button to utilize AppViewModel functionality
                    
                    Button(action: {
                        
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        
                        viewModel.signIn(email: self.email, password: self.password)
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    .padding()
                    
//                    // Nav link to home page
//                    NavigationLink(destination: HomeView(), label: {Text("Sign In") })
//                        .buttonStyle(MyButtonStyle(color: .blue))
//                        .foregroundColor(.blue)
//                        .navigationBarTitle("Sign in")
//
                    // Nav link to register screen
                    NavigationLink(destination: RegisterView(), label: {Text("New user?") })
                        .foregroundColor(.blue)
                }
                .padding()
                Spacer()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("Sign In")
    }
    func validate() {
        if self.email == "" || self.password == "" {
            self.invalid = true
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
