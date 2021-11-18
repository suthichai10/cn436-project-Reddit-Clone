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
        fetchGroupFollowers()
        checkFollow()
    }
    
    func changeBackgroundImage(image: UIImage) {
        ImageUploader.uploadImage(image: image, type: .group) { imageURL in
            guard let userID = AuthViewModel.shared.currentUser?.id else { return }
            guard let groupID = self.group.id else { return }
            Firestore.firestore().collection("groups").document(userID).collection("user-groups").document(groupID).updateData([
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
            Firestore.firestore().collection("groups").document(userID).collection("user-groups").document(groupID).updateData([
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
        
        Firestore.firestore().collection("groups").document(userID).collection("user-groups").addDocument(data: data)
    }
    
    func follow() {
        if let didFollow = group.didFollow , didFollow {
            return
        }
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        guard let groupID = group.id else { return }
        
        let data = [
            "username" : user.username,
            "email" : user.email,
            "fullname" : user.fullname
        ]
        
        Firestore.firestore().collection("groups-following").document(groupID).collection("user-following").document(userID).setData(data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("group-followers").document(groupID).collection("user-followers").document(userID).setData(data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.group.didFollow = true
                self.fetchGroupFollowers()
            }
            
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
            Firestore.firestore().collection("group-followers").document(groupID).collection("user-followers").document(userID).setData([:]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.group.didFollow = false
                self.fetchGroupFollowers()
            }
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
    
    func fetchGroupFollowers() {
        guard let groupID = group.id else { return }
        
        Firestore.firestore().collection("group-followers").document(groupID).collection("user-followers").getDocuments { (snap,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.group.groupStat.followers = documents.count
            self.group.followers = documents.compactMap {
                try? $0.data(as: User.self)
            }
        }
    }
}
