//
//  WebViewController.swift
//  nytimes
//
//  Created by Shantanu Khanwalkar on 07/07/18.
//  Copyright © 2018 Shantanu Khanwalkar. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webUrl: URL?

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        setupView()
        
        if let url = webUrl {
            webView.load(URLRequest(url: url))
        }
    }
    
    // MARK: - View Methods
    
    private func setupView() {
        
        // Configure Activity Indicator View
        activityIndicatorView.startAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
}

extension WebViewController: WKNavigationDelegate {
    
    // MARK: - WKWeb View Delegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicatorView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicatorView.stopAnimating()
    }
}
