//
//  DashboardViewController.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import Photos

class DashboardViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet private weak var webView: UIWebView!
    
    var latestStream: Livestream?
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        
        self.webView.delegate = self
        
        // Request photos authorization
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    print("Authorization succeeded")
                } else {
                    print("Authorization failed")
                }
            })
        }
        
        Database.database().reference().child("livestream").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let livestreamDict = snap.value as? [String:Any] {
                        let key = snap.key
                        guard let url = livestreamDict["livestreamURL"] as? String else { return }
                        let livestream = Livestream(livestreamKey: key, livestreamURL: url)
                        self.latestStream = livestream
                    }
                }
            }
            self.showLiveStream()
        })
    }
    
    private func showLiveStream() {
        if let latestStream = latestStream {
            if let streamURL = latestStream.livestreamURL {
                guard let url = URL(string: streamURL) else { return }
                let urlReqest = URLRequest(url: url)
                self.webView.loadRequest(urlReqest)
            }
        }
    }
    
    @IBAction func addImage(_ sender: UIBarButtonItem) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
}

extension DashboardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            FirebaseService.shared.uploadImage(withImage: image) { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("An unknown error occurred")
                }
            }
        }
    }
}

