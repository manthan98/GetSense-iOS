//
//  FirebaseService.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-25.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import FirebaseStorage

class FirebaseService {
    
    static let shared = FirebaseService()
    
    let storageRef = Storage.storage().reference().child("images")
    
    func uploadImage(withImage image: UIImage, completion: @escaping (_ success: Bool) -> ()) {
        if let imageData = UIImageJPEGRepresentation(image, 0.2) {
            let imageUID = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            FirebaseService.shared.storageRef.child(imageUID).putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    // TODO:
                } else {
                    FirebaseService.shared.storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print("Unable to upload image to Firebase storage")
                            completion(false)
                        } else {
                            guard let url = url else { return }
                            print("Successfully uploaded image to Firebase storage: \(url)")
                            completion(true)
                        }
                    })
                }
            }
        }
    }
    
}
