//
//  DataService.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-25.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation

class DataService {
    
    // Singleton
    static let shared = DataService()
    
    let API_URL = "https://vishvajit79.lib.id/getsense@dev/uploadImageToClarifai/"
    
    var images = [Image]()
    
    func getImage(withImageURL imageURL: String, completion: @escaping (_ success: Bool) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let temp = imageURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let testURL = "\(API_URL)?image_URL=\(temp!)"
        
        guard let url = URL(string: testURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task completed: \(statusCode) - \(url)")
                completion(true)
            } else {
                print("URL session task failed: \(error?.localizedDescription)")
                completion(false)
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}
