//
//  Chemobrain_Training_AppApp.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/3/21.
//

import SwiftUI
import Firebase

@main
struct Chemobrain_Training_AppApp: App {
    
    // Create instance of app delegate for Firebase Authentication
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    // Create StateObject for GamsCene transitions
    @StateObject var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            let viewModel = AppViewModel()
            
            ContentView().environmentObject(viewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        // Configure firebase instance
        FirebaseApp.configure()
        
        return true
    }
}
