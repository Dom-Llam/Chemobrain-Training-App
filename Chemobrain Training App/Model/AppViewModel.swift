//
//  AppViewModel.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/24/21.
//

import SwiftUI
import FirebaseAuth

// Class for current view

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var showingGame = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func playGame() {
        self.showingGame.toggle()
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            // Successful login
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            // Successful login
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        
        self.signedIn = false
    }
    
}
