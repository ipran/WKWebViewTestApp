//
//  ViewController.swift
//  WKWebViewTestApp
//
//  Created by Pranil on 12/2/17.
//  Copyright © 2017 pranil. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpWebView()
        
        let request = URLRequest(url: URL(string: "https://developer.apple.com/documentation/webkit/wkwebview")!)
        webView.load(request)
        view.addSubview(webView)
        
    }
    
    func setUpWebView()
    {
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        
        webView = WKWebView(frame: view.frame, configuration: config)
        webView.navigationDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // PRAGMA MARK : WKWebView Datasource
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(webView.url!)
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        print(webView.url!)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        print("error  - \(error)")
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let urlResponse = navigationResponse.response as? HTTPURLResponse,
            let url = urlResponse.url,
            let allHeaderFields = urlResponse.allHeaderFields as? [String : String] {
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFields, for: url)
            HTTPCookieStorage.shared.setCookies(cookies , for: urlResponse.url!, mainDocumentURL: nil)
            decisionHandler(.allow)
        }
    }
    
    
}

