//
//  ImagesViewController.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    var dataService = DataService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.dataService.delegate = self
        
        DataService.shared.getImages()
    }

}

extension ImagesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell {
            cell.configureCell(withImage: dataService.images[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataService.images.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 250)
    }
}

extension ImagesViewController: DataServiceDelegate {
    func imageLoaded() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
