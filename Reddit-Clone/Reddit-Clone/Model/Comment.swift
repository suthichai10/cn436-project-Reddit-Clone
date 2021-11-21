//
//  Comment.swift
//  Reddit-Clone
//
//  Created by suthichai on 16/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Comment : Decodable , Identifiable  {
    @DocumentID var id : String?
    let userID : String
    let username : String
    let timestamp : Timestamp
    let commentText : String
    let postOwnerID : String
    
    var profileImageURL : String?
    
    func timestampText() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [ .second , .minute , .hour , .day , .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue() , to: Date()) ?? ""
    }
}
