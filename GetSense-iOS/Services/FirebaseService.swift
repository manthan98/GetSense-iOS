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
            
            self.storageRef.child("images/\(imageUID)").putData(imageData, metadata: metadata) { (metadata, error) in
                if error != nil {
                    print("Unable to upload image to Firebase storage")
                } else {
                   self.storageRef.child("images/\(imageUID)").downloadURL(completion: { (url, error) in
                        if error != nil {
                            print("Unable to upload image to Firebase storage")
                            completion(false)
                        } else {
                            guard let url = url else { return }
                            print("Successfully uploaded image to Firebase storage - \(url)")
                            
                            self.postToFirebase(withImageURL: "\(url)", withTimeStamp: self.getTodayString())
                            
                            // Push to API
//                            DataService.shared.getImage(withImageURL: "\(url)", completion: { (success) in
//                                if success {
//                                    print("Successfully pushed to API service")
//                                }
//                            })
                            
                            completion(true)
                        }
                    })
                }
            }
        }
    }
    
    private func postToFirebase(withImageURL imageURL: String, withTimeStamp timeStamp: String) {
        let post: [String:Any] = [
            "imageURL": imageURL,
            "timeStamp": timeStamp
        ]
        
        let firebasePost = self.databaseRef.childByAutoId()
        firebasePost.setValue(post)
    }
    
    // MARK: - Utility function (should be moved)
    private func getTodayString() -> String{

        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second

        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)

        return today_string
    }
    
}
