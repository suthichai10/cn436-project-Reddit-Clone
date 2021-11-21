//
//  CommentViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 16/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

class CommentViewModel : ObservableObject {
    @Published var comments = [Comment]()
    let post : Post
    
    init(post : Post) {
        self.post = post
        fetchComment()
    }
    
    func uploadComment(comment: String) {
        guard let postID = post.id else { return }
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        let data = [
            "comment" : comment,
            "userID" : userID,
            "username" : user.username,
            "timestamp" : Timestamp(date:Date()),
            "ownerID" : post.ownerID,
            "profileImageURL" : user.profileImageURL as Any
            
        ] as [String : Any]
        
        Firestore.firestore().collection("posts").document(postID).collection("post-comments").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("users").document(userID).collection("user-comments").addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                NotificationViewModel.sendNotification(withUID: self.post.ownerID, type: .comment, post: self.post)
            }
        }
    }
    
    func fetchComment() {
        guard let postID = post.id else { return }
        Firestore.firestore().collection("posts").document(postID).collection("post-comments").order(by: "timestamp" , descending: true).addSnapshotListener { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documentChange = snap?.documentChanges.filter({ $0.type == .added }) else { return }
            
            self.comments.append(contentsOf: documentChange.compactMap {
                try? $0.document.data(as: Comment.self)
            })
        }
    }
    
}
