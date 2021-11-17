//
//  Message.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import Firebase
import FirebaseFirestoreSwift

struct Message : Decodable , Identifiable {
    @DocumentID var id : String?
    let senderID : String
    let receiverID : String
    let message : String
    let timestamp : Timestamp
    
    func timestampText() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [ .second , .minute , .hour , .day , .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: timestamp.dateValue() , to: Date()) ?? ""
    }
}
