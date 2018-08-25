//
//  DataService.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-25.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func imagesLoaded()
}

class DataService {
    
    // Singleton
    static let shared = DataService()
    
    weak var delegate: DataServiceDelegate?
    
    let API_URL = "https://vishvajit79.lib.id/getsense@dev/uploadImageToClarifai/"
    
    var images = [Image]()
    
    func getImage(withImageURL imageURL: String, completion: @escaping (_ success: Bool) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let testURL = "\(API_URL)?image_URL=\(imageURL)"
        
        guard let url = URL(string: testURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task completed: \(statusCode) - \(url)")
                completion(true)
                
                if let data = data {
                    // Nothing - my mind is just wtf?
//                    self.images.append(Image.parseJSON(data: data))
                    self.delegate?.imagesLoaded()
                }
            } else {
                print("URL session task failed: \(error?.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
//    func postImage(imageURL: String, modelID: String?, conceptID: String?, completion: @escaping (_ success: Bool) -> ()) {
//        guard let modelID = modelID else { return }
//        guard let conceptID = conceptID else { return }
//
//        let json: [String:Any] = [
//            "image_URL": imageURL,
//            "model_id": modelID,
//            "concept_id": conceptID
//        ]
//
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
//
//            let sessionConfig = URLSessionConfiguration.default
//            let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//
//            guard let url = URL(string: API_URL) else { return }
//
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST"
//            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpBody = jsonData
//
//            let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//                if error == nil {
//                    let statusCode = (response as! HTTPURLResponse).statusCode
//                    print("URL session task completed: \(statusCode)")
//
//                    if statusCode != 200 {
//                        completion(false)
//                    } else {
//                        completion(true)
//                    }
//                } else {
//                    print("URL session task failed: \(error?.localizedDescription)")
//                }
//            }
//            task.resume()
//            session.finishTasksAndInvalidate()
//        } catch let err {
//            print("URL session task failed: \(err)")
//        }
//    }
    
}
