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
    
    let storageRef = Storage.storage().reference(forURL: "gs://getsense-d4b47.appspot.com").child("201677-toronto-skyline-2012.jpg")
    
}
