//
//  User.swift
//  Reddit-Clone
//
//  Created by suthichai on 15/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

struct User : Decodable , Identifiable  {
    @DocumentID var id : String?
    let username : String
    let email : String
    let fullname : String
    var profileImageURL : String?
    
    var followers : [User]?
    var userStat : UserStat?
    var userCommunityGroup : [RedditGroup]?
    
    var didFollow : Bool? = false
}

struct UserStat : Decodable {
    var follower : Int
    var post : Int
    var comments : Int
}
