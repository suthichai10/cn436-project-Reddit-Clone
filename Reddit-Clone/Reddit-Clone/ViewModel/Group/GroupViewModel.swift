//
//  GroupViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class GroupViewModel : ObservableObject {
    @Published var group : RedditGroup
    @Published var posts = [Post]()
    
    init(group: RedditGroup) {
        self.group = group
        fetchGroupPosts()
        checkFollow()
    }
    
    func changeBackgroundImage(image: UIImage) {
        ImageUploader.uploadImage(image: image, type: .group) { imageURL in
            guard let userID = AuthViewModel.shared.currentUser?.id else { return }
            guard let groupID = self.group.id else { return }
            Firestore.firestore().collection("users").document(userID).collection("groups").document(groupID).updateData([
                "backgroundImageURL" : imageURL
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.group.backgroundImageURL = imageURL
            }
        }
    }
    
    func changeGroupImage(image: UIImage) {
        ImageUploader.uploadImage(image: image, type: .group) { imageURL in
            guard let userID = AuthViewModel.shared.currentUser?.id else { return }
            guard let groupID = self.group.id else { return }
            Firestore.firestore().collection("users").document(userID).collection("groups").document(groupID).updateData([
                "groupImageURL" : imageURL
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.group.groupImageURL = imageURL
            }
        }
    }
    
    func fetchGroupPosts() {
        guard let groupID = group.id else { return }
        
        Firestore.firestore().collection("posts").whereField("ownerID", isEqualTo: groupID).getDocuments { (snap,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            self.posts = documents.compactMap {
                try? $0.data(as: Post.self)
            }
        }
    }
    
    func createGroup(groupname: String , description: String) {
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        
        let data = [
            "ownerID" : userID,
            "groupname" : groupname,
            "description" : description,
            "following" : 0
        ] as [String : Any]
        
        Firestore.firestore().collection("users").document(userID).collection("groups").addDocument(data: data)
    }
    
    func follow() {
        if let didFollow = group.didFollow , didFollow {
            return
        }
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        guard let groupID = group.id else { return }
        
        Firestore.firestore().collection("groups-following").document(groupID).collection("user-following").document(userID).setData([:]) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.group.didFollow = true
        }
    }
    
    func unfollow() {
        if let didFollow = group.didFollow , !didFollow {
            return
        }
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        guard let groupID = group.id else { return }
        
        Firestore.firestore().collection("groups-following").document(groupID).collection("user-following").document(userID).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.group.didFollow = false
        }
    }
    
    func checkFollow() {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        guard let groupID = group.id else { return }
        
        Firestore.firestore().collection("group-following").document(groupID).collection("user-following").document(userID).getDocument { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let didFollow = snap?.exists else { return }
            
            self.group.didFollow = didFollow
        }
    }
}
