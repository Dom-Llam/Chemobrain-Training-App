//
//  Chemobrain_Training_AppApp.swift
//  Chemobrain Training App
//
//  Created by Dominic Bieniewski on 6/3/21.
//

import SwiftUI

@main
struct Chemobrain_Training_AppApp: App {
    @StateObject var page = MyAppEnvironmentData()
    @EnvironmentObject var env : MyAppEnvironmentData
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(page)
        }
    }
}
