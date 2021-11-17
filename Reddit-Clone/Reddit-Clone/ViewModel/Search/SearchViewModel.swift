//
//  SearchViewModel.swift
//  Reddit-Clone
//
//  Created by suthichai on 15/11/2564 BE.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class SearchViewModel : ObservableObject {
    @Published var data = [Data]()
    
    enum Data {
        case RedditUser(user : User)
        case RedditGroup(group: RedditGroup)
    }
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        Firestore.firestore().collection("users").getDocuments { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.data.append(contentsOf: documents.compactMap {
                try? Data.RedditUser(user: $0.data(as:  User.self)!)
            })
        }
        
        Firestore.firestore().collection("groups").getDocuments { (snap , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snap?.documents else { return }
            
            self.data.append(contentsOf: documents.compactMap {
                try? Data.RedditGroup(group: $0.data(as:  RedditGroup.self)!)
            })
        }
    }
    
    func filterData(withText input: String) -> [Data] {
        let lowercase = input.lowercased()
        return data.filter {
            switch $0 {
            case let .RedditUser(user) :
                return user.username.contains(lowercase)
            case let .RedditGroup(group) :
                return group.groupname.contains(lowercase)
            }
        }
    }
    
}

