//
//  ImagesViewController.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ImagesViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        FirebaseService.shared.databaseRef.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                self.images.removeAll()
                for snap in snapshot {
                    if let imageDict = snap.value as? [String:Any] {
                        let key = snap.key
                        guard let imageURL = imageDict["imageURL"] as? String else { return }
                        let image = Image(imageURL: imageURL, imageKey: key)
                        self.images.append(image)
                    }
                }
            }
            self.collectionView.reloadData()
        })
    }

}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell {
            cell.configureCell(withImage: images[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 250)
    }
}
