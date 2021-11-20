//
//  Reddit_CloneApp.swift
//  Reddit-Clone
//
//  Created by suthichai on 12/11/2564 BE.
//

import SwiftUI
import Firebase

@main
struct Reddit_CloneApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
        }
    }
}
