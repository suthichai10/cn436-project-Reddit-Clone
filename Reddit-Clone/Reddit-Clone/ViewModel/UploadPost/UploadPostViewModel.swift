//
//  UploadPostViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

class UploadPostViewModel  {
        
    func uploadPost(caption : String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        let data = [
            "caption" : caption,
            "timestamp" : Timestamp(date: Date()),
            "ownerID" : userID ,
            "ownerUsername" : user.username,
            "likes" : 0
        ] as [String : Any]
        
        Firestore.firestore().collection("posts").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
}
