//
//  ImageCell.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(withImage image: Image) {
        self.detailsLabel.text = image.score
        
        if image.imageURL != nil {
            self.imageView.imageFromServer(withURLString: image.imageURL)
        } else {
            // Show dummy image
        }
    }
    
}
