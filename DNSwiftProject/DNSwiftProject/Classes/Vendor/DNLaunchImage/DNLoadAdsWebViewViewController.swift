//
//  DNLoadAdsWebViewViewController.swift
//  DNSwiftProject
//
//  Created by mainone on 16/12/16.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit

class DNLoadAdsWebViewViewController: UIViewController {
    
    var webView: UIWebView!
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        webView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        view.addSubview(webView)
        webView?.delegate = self
        webView?.scrollView.bounces = false
        webView?.scrollView.showsHorizontalScrollIndicator = false
        webView?.scrollView.isScrollEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let path = urlString ?? "https://www.baid.com"
        let url = URL.init(string: path)
        webView.loadRequest(URLRequest.init(url: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension DNLoadAdsWebViewViewController: UIWebViewDelegate {
    
}
