//
//  WebViewController.swift
//  WroldTrotter
//
//  Created by helloyako on 2017. 3. 25..
//  Copyright © 2017년 helloyako. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.apple.com") { //www.bignerdranch.com can't load
            webView.load(URLRequest(url: url))
        }
    }
}
