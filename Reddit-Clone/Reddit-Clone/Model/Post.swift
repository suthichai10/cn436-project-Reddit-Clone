//
//  Post.swift
//  Reddit-Clone
//
//  Created by suthichai on 15/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

struct Post: Decodable , Identifiable {
    @DocumentID var id : String?
    let caption : String
    var likes : Int
    let imageURL : String?
    let ownerID : String
    let ownerUsername : String
    
    var timestamp : Timestamp
    
    let groupID : String?
    let groupName : String?
    
    var user : User?
    var didLike : Bool? = false
    
    func timestampText() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [ .second , .minute , .hour , .day , .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue() , to: Date()) ?? ""
    }
}
