//
//  ImageUploader.swift
//  Reddit-Clone
//
//  Created by suthichai on 17/11/2564 BE.
//

import SwiftUI
import Firebase

struct ImageUploader {
    
    enum UploadType {
        case profile
        case group
        case post
        
        var filePath: StorageReference {
            let filename = NSUUID().uuidString
            switch self {
            case .profile:
                return Storage.storage().reference(withPath: "/profile_images/\(filename)")
            case .group:
                return Storage.storage().reference(withPath: "/group_images/\(filename)")
            case .post:
                return Storage.storage().reference(withPath: "/post_images/\(filename)")
            }
        }
    }
    
    static func uploadImage(image: UIImage , type: UploadType , completion: @escaping (String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        
        let ref = type.filePath
        
        ref.putData(imageData , metadata: nil) { (_ , error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            ref.downloadURL { (url , error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let imageURL = url?.absoluteString else { return }
                
                completion(imageURL)
            }
        }
    }
    
}
