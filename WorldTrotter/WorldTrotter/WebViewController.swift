//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by helloyako on 2016. 7. 18..
//  Copyright © 2016년 helloyako. All rights reserved.
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
        let url = NSURL(string: "https://www.bignerdranch.com")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
    }
    
}
