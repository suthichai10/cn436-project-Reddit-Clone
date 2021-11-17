//
//  UploadPostViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

class UploadPostViewModel  {
    
    let postType : PostType
    
    init(postType : PostType) {
        self.postType = postType
    }
    
    func uploadPost() {
        switch postType {
        case .user(let caption):
            uploadUserPost(caption: caption)
        case .group(let groupID , let groupName ,let caption) :
            uploadGroupPost(groupID: groupID ,groupName: groupName ,caption: caption)
        }
    }
    
    func uploadUserPost(caption: String) {
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
    
    func uploadGroupPost(groupID: String , groupName: String ,caption: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        let data = [
            "caption" : caption,
            "timestamp" : Timestamp(date: Date()),
            "ownerID" : userID,
            "ownerUsername" : user.username,
            "groupID" : groupID,
            "groupName" : groupName,
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

enum PostType {
    case user(String)
    case group(String , String , String)
}
