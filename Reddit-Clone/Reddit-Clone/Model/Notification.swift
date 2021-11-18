//
//  Notification.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Notification: Decodable , Identifiable {
    @DocumentID var id : String?
    var postID : String?
    var username : String
    var profileImageURL : String?
    var timestamp : Timestamp
    var userID : String
    
    var type : NotificationType
    
}

enum NotificationType : Int ,Decodable {
    case follow
    case comment
    case like
    
    var notificationMessage : String {
        switch self {
        case .follow :
            return " started following you."
        case .comment:
            return " comment on your posts."
        case .like:
            return " liked one of your posts."
        }
    }
}
