//
//  DNWKWebViewController.swift
//  DNSwiftDemo
//
//  Created by mainone on 16/11/23.
//  Copyright © 2016年 wjn. All rights reserved.
//

import UIKit
import WebKit

class DNWKWebViewController: DNBaseViewController {

    var urlString: String?
    var delayTime: Double?
    
    deinit {
        print("deinit wkwebvc")
        self.progressView.progress = 0.0;
        self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView.removeObserver(self, forKeyPath: "title")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadWebViewWithUrlString(urlString: self.urlString!)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.webView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.addWeixinShareView))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    // 重写返回事件
    override func backBtnClick() {
        if self.webView.canGoBack {
            self.webView.goBack()
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    
    // 加载网页
    private func loadWebViewWithUrlString(urlString: String) {
        if !urlString.isEmpty {
            if let url = URL(string: urlString) {
                self.webView.load(URLRequest(url: url))
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            if self.webView.estimatedProgress < 1.0 {
                self.delayTime = 1.0 - self.webView.estimatedProgress;
                return;
            } else {
                DispatchQueue.main.async {
                    self.progressView.progress = 0.0
                }
            }
        } else if keyPath == "title" {
            self.title = self.webView.title
        }
    }
    
    // MARK: Setter&Getter
    lazy var webView: WKWebView = {
        let webV = WKWebView(frame: self.view.bounds, configuration: self.config)
        webV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(webV)
        // 代理
        webV.navigationDelegate = self
        webV.uiDelegate = self
        // 支持侧滑手势
        webV.allowsBackForwardNavigationGestures = true
        
        return webV
    }()
    
    private lazy var config: WKWebViewConfiguration = {
        let webVConfig = WKWebViewConfiguration()
        // 支持内嵌视频播放
        webVConfig.allowsInlineMediaPlayback = true
        return webVConfig
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressV = UIProgressView(frame: CGRect(x: 0, y: 44, width: self.view.bounds.size.width, height: 2))
        progressV.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin]
        progressV.progressTintColor = UIColor.green
        progressV.trackTintColor = UIColor.clear
        self.navigationController!.navigationBar.addSubview(progressV)
        return progressV;
    }()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}

extension DNWKWebViewController: WKNavigationDelegate {
    // 在发送请求之前，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        print(#function)
        let URL = navigationAction.request.url
        print(URL?.absoluteString ?? "没有UrlString")
        
        decisionHandler(.allow)
    }
    // 在收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(#function)
        decisionHandler(.allow);
    }
    // 开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print(#function)
    }
    // 加载完成
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(#function)
        
    }
    // 内容开始返回
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    // 加载完成
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print(#function)
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    // 加载失败
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(#function)
    }
//    // 身份验证(加载HTTPS的链接，需要权限认证时调用)
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
//        print(#function)
//    }
//    // 终止页面加载
//    @available(iOS 9.0, *)
//    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
//        print(#function)
//    }
}

extension DNWKWebViewController: WKUIDelegate {
    // 创建一个新的WebView
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return nil
    }
    // 弹出警告框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Swift.Void) {
        print(#function)
    }
    // 弹出确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Swift.Void) {
        print(#function)
    }
    // 弹出输入框
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Swift.Void) {
        print(#function)
    }
//    // 通知应用程序正常关闭
//    @available(iOS 9.0, *)
//    func webViewDidClose(_ webView: WKWebView) {
//        print(#function)
//    }
//    // 元素是否预览页面
//    @available(iOS 10.0, *)
//    func webView(_ webView: WKWebView, shouldPreviewElement elementInfo: WKPreviewElementInfo) -> Bool {
//        print(#function)
//        return true
//    }
//    // 提供一个自定义的视图控制器显示给定的元素
//    @available(iOS 10.0, *)
//    func webView(_ webView: WKWebView, previewingViewControllerForElement elementInfo: WKPreviewElementInfo, defaultActions previewActions: [WKPreviewActionItem]) -> UIViewController? {
//        print(#function)
//        return nil
//    }
//    // pop预览视图控制器
//    @available(iOS 10.0, *)
//    func webView(_ webView: WKWebView, commitPreviewingViewController previewingViewController: UIViewController) {
//        print(#function)
//    }
}

extension DNWKWebViewController: DNCustomShareViewDelegate {
    
    func addWeixinShareView() {
        let shareArray = [["image":"qq_haoyou", "title":"QQ"],
                          ["image":"qq_kongjian", "title":"QQ空间"],
                          ["image":"weixin_haoyou", "title":"微信"],
                          ["image":"weixin_pengyouquan", "title":"朋友圈"],
                          ["image":"liulanqi_safari", "title":"Safari打开"],
                          ["image":"email", "title":"邮箱"],
                          ["image":"Action_Copy", "title":"复制链接"],
                          ["image":"Action_Collection", "title":"收藏网页"],
                          ["image":"Action_Refresh", "title":"刷新"],
                          ["image":"Action_Report", "title":"举报"]]
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 30))
        let headerTitleLabel = UILabel(frame: CGRect(x: 0, y: 9, width: headerView.frame.size.width, height: 11))
        headerTitleLabel.textAlignment = .center
        headerTitleLabel.textColor = UIColor(red: 99.0/255.0, green: 98.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        headerTitleLabel.backgroundColor = UIColor.clear
        headerTitleLabel.font = UIFont.systemFont(ofSize: 11)
        if let usrStr = self.webView.url?.host {
            headerTitleLabel.text = "网页由 \(usrStr) 提供"
        }
        headerView.addSubview(headerTitleLabel)
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 80))
        footerView.backgroundColor = UIColor.red
        
        let shareView = DNCustomShareView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        shareView.customHeaderView = headerView
        //        shareView.customFooterView = footerView
        
        let height = shareView.getBoderViewHeight(shareArray as [AnyObject], myFirstCount: 6)
        shareView.boderView.frame = CGRect(x: 0, y: 0, width: shareView.frame.size.width, height: height)
        shareView.setShare(shareArray as Array<AnyObject>, delegate: self)
        self.view.window?.addSubview(shareView)
        
    }
    
    func customShareViewButtonAction(_ shareView: DNCustomShareView, title: String) {
        print(title)
        
        if let webUrl = self.webView.url {
            if title == "Safari打开" {
                UIApplication.shared.openURL(webUrl)
            } else if title == "复制链接" {
                let pasteboard = UIPasteboard.general
                pasteboard.string = webUrl.absoluteString
            } else if title == "刷新" {
                DispatchQueue.main.async {
                    self.webView.reload()
                }
            }
        }
        
    }
}


