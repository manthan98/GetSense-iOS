//
//  DashboardViewController.swift
//  GetSense-iOS
//
//  Created by Manthan Shah on 2018-08-24.
//  Copyright © 2018 Manthan Shah. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    let streamURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        
        self.showLiveStream()
    }
    
    private func showLiveStream() {
        guard let url = URL(string: streamURL) else { return }
        let urlRequest = URLRequest(url: url)
        self.webView.loadRequest(urlRequest)
    }

}

