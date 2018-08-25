//
//  FirebaseService.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-25.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

class FirebaseService {
    
    static let shared = FirebaseService()
    
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference().child("images")
    
    func uploadImage(withImage image: UIImage, completion: @escaping (_ success: Bool) -> ()) {
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            let imageUID = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            let testUpload = self.storageRef.child("images/\(imageUID)")
            
            testUpload.putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    // TODO:
                } else {
                   testUpload.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print("Unable to upload image to Firebase storage")
                            completion(false)
                        } else {
                            guard let url = url else { return }
                            print("Successfully uploaded image to Firebase storage: \(url)")
                            
                            self.postToFirebase(imageURL: "\(url)")
                            
                            // Push to API
//                            DataService.shared.postImage(imageURL: "\(url)", modelID: nil, conceptID: nil, completion: { (success) in
//                                if success {
//                                    print("YAY!")
//                                }
//                            })
                            
                            completion(true)
                        }
                    })
                }
            }
        }
    }
    
    private func postToFirebase(imageURL: String) {
        let post: [String:Any] = [
            "imageURL": imageURL
        ]
        
        let firebasePost = self.databaseRef.childByAutoId()
        firebasePost.setValue(post)
    }
    
}
