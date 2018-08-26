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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 7.0
    }
    
    func configureCell(withImage image: Image) {
        if let imageKey = image.imageKey {
            self.detailsLabel.text = imageKey
        }
        
        if let imageURL = image.imageURL {
            self.imageView.imageFromServer(withURLString: imageURL)
        }
    }
    
}
