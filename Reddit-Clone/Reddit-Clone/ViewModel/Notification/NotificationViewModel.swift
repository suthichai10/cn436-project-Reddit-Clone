//
//  NotificationViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class NotificationViewModel : ObservableObject {
    @Published var notification = [Notification]()
    
    init() {
        fetchNotication()
    }
    
    func fetchNotication() {
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        
        Firestore.firestore().collection("notifications").document(userID).collection("user-notifications").getDocuments { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.notification = documents.compactMap {
                try? $0.data(as: Notification.self)
            }
        }
    }
    
    static func sendNotification(withUID uid: String , type: NotificationType , post: Post? = nil) {
        guard let user = AuthViewModel.shared.currentUser else { return }
        guard let userID = user.id else { return }
        
        var data = [
            "timestamp" : Timestamp(date:Date()),
            "username" : user.username,
            "userID" : userID,
            "profileImageURL" : user.profileImageURL as Any,
            "type" : type.rawValue
        ] as [String : Any]
        
        if let post = post , let id = post.id {
            data["postID"] = id
        }
        
        Firestore.firestore().collection("notifications").document(uid).collection("user-notifications").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
}
