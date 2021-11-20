//
//  UploadPostViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class UploadPostViewModel : ObservableObject {
    
    let postType : PostType
    
    init(postType : PostType) {
        self.postType = postType
    }
    
    func uploadPost() {
        switch postType {
        case .user(let image ,let caption):
            uploadUserPost(image: image ,caption: caption)
        case .group(let image ,let groupID , let groupName ,let caption) :
            uploadGroupPost(image: image,groupID: groupID ,groupName: groupName ,caption: caption)
        }
    }
    
    func uploadUserPost(image: UIImage? , caption: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        var data = [
            "caption" : caption,
            "timestamp" : Timestamp(date: Date()),
            "ownerID" : userID ,
            "ownerUsername" : user.username,
            "likes" : 0
        ] as [String : Any]
        
        if let image = image {
            ImageUploader.uploadImage(image:image , type:.post) { imageURL in
                data.updateValue(imageURL , forKey: "imageURL")
            }
        }
        
        Firestore.firestore().collection("posts").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    func uploadGroupPost(image: UIImage?, groupID: String , groupName: String ,caption: String) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        var data = [
            "caption" : caption,
            "timestamp" : Timestamp(date: Date()),
            "ownerID" : userID,
            "ownerUsername" : user.username,
            "groupID" : groupID,
            "groupName" : groupName,
            "likes" : 0
        ] as [String : Any]
        
        if let image = image {
            ImageUploader.uploadImage(image:image,type: .post) { imageURL in
                data.updateValue(imageURL, forKey: "imageURL")
            }
        }
        
        Firestore.firestore().collection("posts").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
        
    }
}

enum PostType {
    case user(UIImage ,String)
    case group(UIImage ,String , String , String)
}
