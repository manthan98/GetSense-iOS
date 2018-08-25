//
//  UIImageView.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func imageFromServer(withURLString urlString: String) {
        let url = URL(string: urlString)
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let url = url {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            imageCache.setObject(image, forKey: urlString as NSString)
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
