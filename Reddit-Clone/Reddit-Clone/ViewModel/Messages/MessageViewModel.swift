//
//  MessageViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class MessageViewModel : ObservableObject {
    @Published var messages = [Message]()
    let user : User
    
    init(user: User) {
        self.user = user
        fetchMessage()
    }
    
    func sendMessage(message: String) {
        guard let senderID = AuthViewModel.shared.currentUser?.id else { return }
        guard let receiverID = user.id else { return }
        
        let data = [
            "senderID" : senderID,
            "receiverID" : receiverID,
            "timestamp" : Timestamp(date:Date()),
            "message" : message
        ] as [String : Any]
        
        Firestore.firestore().collection("messages").document(senderID).collection("user-messages").document(receiverID).collection("messages").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            Firestore.firestore().collection("messages").document(receiverID).collection("user-messages").document(senderID).collection("messages").addDocument(data: data) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
            
        }
    }
    
    func fetchMessage() {
        guard let senderID = AuthViewModel.shared.currentUser?.id else { return }
        guard let receiverID = user.id else { return }
        
        Firestore.firestore().collection("messages").document(senderID).collection("user-messages").document(receiverID).collection("messages").order(by: "timestamp" , descending: false).addSnapshotListener { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.messages = documents.compactMap {
                try? $0.data(as: Message.self)
            }
        }
    }
}
