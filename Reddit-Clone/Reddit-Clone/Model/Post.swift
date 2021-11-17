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
    var ownerID : String
    var ownerUsername : String
    
    let groupID : String?
    let groupName : String?
    
    var user : User?
    var didLike : Bool? = false
}
