//
//  FeedCellViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 15/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class FeedCellViewModel: ObservableObject {
    @Published var post : Post
    
    init(post : Post) {
        self.post = post
        checkLike()
    }
    
    func like() {
        if let didLike = self.post.didLike , didLike {
            return
        }
        guard let postID = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore().collection("posts").document(postID).collection("posts-likes").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(postID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                Firestore.firestore().collection("posts").document(postID).updateData([
                    "likes" : self.post.likes + 1
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                self.post.likes += 1
                self.post.didLike = true
                NotificationViewModel.sendNotification(withUID: self.post.ownerID, type: .like)
            }
            
        }
    }
    
    func unlike() {
        if let didLike = self.post.didLike , !didLike {
            return
        }
        guard let postID = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore().collection("posts").document(postID).collection("posts-likes").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            Firestore.firestore().collection("users").document(userID).collection("user-likes").document(postID).delete() { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                Firestore.firestore().collection("posts").document(postID).updateData([
                    "likes" : self.post.likes - 1
                ]) { error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                }
                self.post.likes -= 1
                self.post.didLike = false
            }
        }
    }
    
    func checkLike() {
        guard let postID = post.id else { return }
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        
        Firestore.firestore().collection("posts").document(postID).collection("posts-likes").document(userID).getDocument { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let didLike = snap?.exists else { return }
            self.post.didLike = didLike
        }
    }
}
