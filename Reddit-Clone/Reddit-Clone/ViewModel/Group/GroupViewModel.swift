//
//  GroupViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class GroupViewModel : ObservableObject {

    func createGroup(groupname: String , description: String) {
        guard let userID = AuthViewModel.shared.currentUser?.id else { return }
        
        let data = [
            "ownerID" : userID,
            "groupname" : groupname,
            "description" : description,
            "following" : 0
        ] as [String : Any]
        
        Firestore.firestore().collection("groups").document(userID).collection("user-groups").addDocument(data: data)
    }
 
}
