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
    let groupname : String
    var description : String
    var following : Int
    
}
