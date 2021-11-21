//
//  UserCommentViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 16/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

class UserCommentViewModel : ObservableObject {
    @Published var comments = [Comment]()
    
    init() {
        fetchUserComment()
    }
    
    func fetchUserComment() {
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        Firestore.firestore().collection("users").document(userID).collection("user-comments").order(by: "timestamp" , descending: true).getDocuments { (snap,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let document = snap?.documents else { return }
            
            self.comments.append(contentsOf: document.compactMap {
                try? $0.data(as: Comment.self)
            })
            
        }
    }
}
