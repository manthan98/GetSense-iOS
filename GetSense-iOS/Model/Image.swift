//
//  Image.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation

class Image {
    
    var score = String()
    var imageURL = String()
    var error = Bool()
    var errorMessage = String()
    
    static func parseJSON(data: Data) -> Image {
        let image = Image()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            if let json = jsonResult as? [String:Any] {
                if let score = json["score"] as? String {
                    image.score = score
                }
                
                if let imageURL = json["url"] as? String {
                    image.imageURL = imageURL
                }
                
                if let error = json["error"] as? Bool {
                    image.error = error
                }
                
                if let errorMessage = json["errMessage"] as? String {
                    image.errorMessage = errorMessage
                }
            }
        } catch let err {
            print(err.localizedDescription)
        }
        
        return image
    }
    
}
