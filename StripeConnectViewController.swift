//
//  StripeConnectViewController.swift
//  StripeConnectApp
//
//  Created by Mohau Mpoti on 18/10/17.
//
//  email: mohau@openbeacon.biz
//
//  Copyright © 2017 Swift Tutorials. All rights reserved.
//

import UIKit

class StripeConnectViewController: UIViewController, UIWebViewDelegate {
    
    
    @IBOutlet weak var webview: UIWebView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //replace this with your Heroku hosted Node.js App url
    let url = URL(string: "https://my-customurl-73648.herokuapp.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.delegate = self
        activityIndicatorView.isHidden = true
        
        
        guard let url = self.url else {
            self.alert(message: "The URL seems to be Invalid.")
            return
        }
        
        let path: String = "/authorize"
        
        let cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        let timeout: TimeInterval = 6.0
        var request = URLRequest(url: url.appendingPathComponent(path), cachePolicy: cachePolicy, timeoutInterval: timeout)
        
        request.httpMethod = "GET"
        
        activityIndicatorView.isHidden = false
        webview.loadRequest(request)
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicatorView.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicatorView.isHidden = true
        activityIndicatorView.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.alert(message: error.localizedDescription)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url {
            
            if let urlComponents = URLComponents(string: url.absoluteString) {
                if let queryString = urlComponents.queryItems {
                    for query in queryString {
                        if query.name == "stripe_user_id" {
                            if let value = query.value {
                                
                                //If authentication to your Stripe Account was successful, the Stripe User ID will be returned as a query string in the variable 'value'.  You can then proceed to save it to your application’s database, to use at a later stage for any subsequent Stripe connection requests.
                                
                                print("Stripe User ID = \(value)")
                            }
                        }
                    }
                }
            }
        }
        
        return true
    }
    
    func alert(message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(action)
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.present(alertController, animated: true, completion: nil)
        })
    }

}
