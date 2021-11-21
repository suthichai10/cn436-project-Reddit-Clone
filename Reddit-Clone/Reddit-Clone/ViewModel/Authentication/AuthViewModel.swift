//
//  AuthViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 15/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var userSession : Firebase.User?
    @Published var currentUser : User?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(withEmail email: String , password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            
            self.userSession = user
            
            self.fetchUser()
        }
    }
    
    func signOut() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func register(withEmail email: String , password : String , username: String , fullname : String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = result?.user else { return }
            
            let data = [
                "username" : username,
                "email" : email,
                "fullname" : fullname
            ]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
        }
        
    }
    
    func fetchUser() {
        guard let userID = userSession?.uid else { return }
        
        Firestore.firestore().collection("users").document(userID).getDocument { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = try? snap?.data(as: User.self) else { return }
            
            self.currentUser = user
        }
    }
}

