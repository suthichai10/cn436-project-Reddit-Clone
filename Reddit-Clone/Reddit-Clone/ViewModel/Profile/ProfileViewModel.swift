//
//  ProfileViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 16/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class ProfileViewModel: ObservableObject {
    @Published var user : User
    
    init(user: User) {
        self.user = user
        fetchUserFollower()
        fetchUserGroup()
        checkFollow()
        checkStat()
    }
    
    func changeProfileImage(image: UIImage) {
        ImageUploader.uploadImage(image: image, type: .profile) { imageURL in
            guard let userID = self.user.id else { return }
            Firestore.firestore().collection("users").document(userID).updateData([
                "profileImageURL" : imageURL
            ]) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.user.profileImageURL = imageURL
            }

        }
    }
    
    func follow() {
        if let didFollow = user.didFollow , didFollow {
            return
        }
        guard let uid = user.id else { return }
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        
        let data = [
            "username" : user.username,
            "email" : user.email,
            "fullname" : user.fullname
        ]
        
        Firestore.firestore().collection("following").document(userID).collection("user-following").document(uid).setData(data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(userID).setData(data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.user.didFollow = true
                self.checkFollow()
            }
        }
    }
    
    func unfollow() {
        if let didFollow = user.didFollow , !didFollow {
            return
        }
        guard let uid = user.id else { return }
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        Firestore.firestore().collection("following").document(userID).collection("user-following").document(uid).delete() { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("followers").document(uid).collection("user-followers").document(userID).delete() { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                self.user.didFollow = false
                self.checkFollow()
            }
        }
    }
    
    func checkFollow() {
        guard let uid = user.id else { return }
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        
        Firestore.firestore().collection("following").document(uid).collection("user-following").document(userID).getDocument { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let didFollow = snap?.exists else { return }
            
            self.user.didFollow = didFollow
        }
    }
    
    func checkStat() {
        guard let userID = user.id else { return }
        Firestore.firestore().collection("users").document(userID).collection("user-comments").getDocuments { (snap ,error ) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let commentsCount = snap?.count else { return }
            
            Firestore.firestore().collection("followers").document(userID).collection("user-followers").getDocuments { (snap , error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let followersCount = snap?.count else { return }
                
                Firestore.firestore().collection("posts").whereField("ownerID" , isEqualTo: userID).getDocuments { (snap , error) in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }
                        
                    guard let postsCount = snap?.count else { return }
                    
                    self.user.userStat = UserStat(follower: followersCount, post: postsCount, comments: commentsCount)
                }
            }
        }
    }
    
    
    func fetchUserFollower() {
        guard let userID = user.id else { return }
        
        Firestore.firestore().collection("followers").document(userID).collection("user-followers").getDocuments { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.user.followers = documents.compactMap {
                try? $0.data(as: User.self)
            }
        }
    }
    
    func fetchUserGroup() {
        guard let userID = user.id else { return }
        
        Firestore.firestore().collection("users").document(userID).collection("groups").getDocuments { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.user.userCommunityGroup = documents.compactMap {
                try? $0.data(as: RedditGroup.self)
            }
        }
    }
    
}
