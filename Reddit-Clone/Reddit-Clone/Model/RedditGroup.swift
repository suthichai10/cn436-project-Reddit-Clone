//
//  Group.swift
//  Reddit-Clone
//
//  Created by suthichai on 16/11/2564 BE.
//

import Foundation
import FirebaseFirestoreSwift

struct RedditGroup: Decodable , Identifiable {
    @DocumentID var id : String?
    let ownerID : String
    let groupname : String
    var description : String
    var groupImageURL : String?
    var backgroundImageURL : String?
    var user_followers : [User]?
    
    var groupStat : GroupStat?
    
    var didFollow: Bool? = false
}

struct GroupStat : Decodable {
    var followers : Int
}
