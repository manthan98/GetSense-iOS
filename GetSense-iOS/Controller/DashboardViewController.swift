//
//  DashboardViewController.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import FirebaseStorage
import Photos

class DashboardViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet private weak var webView: UIWebView!
    
    var imagePicker = UIImagePickerController()
    
    let streamURL = "https://0808fbe2.ngrok.io"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        
        self.webView.delegate = self
        
        self.showLiveStream()
        
        // Request photos authorization
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    print("Great")
                } else {
                    print("Authorization failed")
                }
            })
        }
    }
    
    private func showLiveStream() {
        if let url = URL(string: streamURL) {
            let urlRequest = URLRequest(url: url)
            self.webView.loadRequest(urlRequest)
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

