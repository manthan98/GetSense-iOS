//
//  PiViewController.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-25.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PiViewController: UIViewController {
    
    var latestStream: PiStream?

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("pistream").observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let livestreamDict = snap.value as? [String:Any] {
                        let key = snap.key
                        guard let url = livestreamDict["pistreamURL"] as? String else { return }
                        let pistream = PiStream(piStreamKey: key, piStreamURL: url)
                        self.latestStream = pistream
                    }
                }
            }
            self.showLiveStream()
        })
    }
    
    private func showLiveStream() {
        if let latestStream = latestStream {
            if let streamURL = latestStream.piStreamURL {
                guard let url = URL(string: streamURL) else { return }
                let urlReqest = URLRequest(url: url)
                self.webView.loadRequest(urlReqest)
            }
        }
    }

}
