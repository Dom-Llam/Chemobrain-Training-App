//
//  AppViewModel.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/24/21.
//

import SwiftUI
import FirebaseAuth
import Firebase

// Class for current view

class AppViewModel: ObservableObject {
    
    // For backside server and user auth
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    // For the timer and score
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @Published var score: Int = 0
    
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
                print("an error took place creating user\(error!)")
                return
            }
            
            // Create user instance of firebase.auth in firebase.firestore?
            self?.db.collection("users").document().setData(["UserName": email, "Password": password])
            
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
    
    func addInfo() {
        
        // More to come
        db.collection("U")
    }
    
}
