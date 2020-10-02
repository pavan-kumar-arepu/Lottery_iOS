//
//  WebViewController.swift
//  Lottery
//
//  Created by GuestUserLogin on 30/09/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//


import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate {
    var urlString = ""
    var titleLabel = "Dashboard"
    var webView: WKWebView!
    var indicator = ActivityIndicatorService()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: ImageProvider.closeIcon, style: .plain, target: self, action: #selector(backAction))
        self.title = titleLabel
        if let url = URL(string: urlString) {
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
            DispatchQueue.main.async {
                self.indicator.showActivityIndicator(viewController: self)
            }
        }
    }
    
    @objc func scanAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    @objc func backAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Hide Sinner
        DispatchQueue.main.async {
            self.indicator.hideActivityIndicator(viewController: self)
        }
    }
}
