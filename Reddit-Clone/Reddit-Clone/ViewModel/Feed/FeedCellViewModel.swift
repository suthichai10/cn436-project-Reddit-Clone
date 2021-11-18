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
    }
    
    func like() {
        if let didLike = self.post.didLike , didLike {
            return
        }
        guard let postID = post.id else { return }
        guard let userID = AuthViewModel.shared.userSession?.uid else { return }
        Firestore.firestore().collection("posts").document(postID).setData([:]) { error in
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
        Firestore.firestore().collection("posts").document(postID).setData([:]) { error in
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
}
