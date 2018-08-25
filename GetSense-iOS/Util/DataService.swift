//
//  DataService.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-25.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import Foundation

protocol DataServiceDelegate: class {
    func imageLoaded()
}

class DataService {
    
    // Singleton
    static let shared = DataService()
    
    weak var delegate: DataServiceDelegate?
    
    let API_URL = "https://vishvajit79.lib.id/getsense@dev/"
    var images = [Image]()
    
    func getImages() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        guard let url = URL(string: API_URL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error == nil {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("URL session task completed: \(statusCode)")
                
                if let data = data {
                    self.images.append(Image.parseJSON(data: data))
                    self.delegate?.imageLoaded()
                }
            } else {
                print("URL session task failed: \(error?.localizedDescription)")
            }
        }
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}
