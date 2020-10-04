//
//  DashboardViewController.swift
//  Lottery
//
//  Created by GuestUserLogin on 01/10/20.
//  Copyright © 2020 Lottery_App_iOS. All rights reserved.
//

import UIKit
import WebKit

class DashboardViewController: UIViewController {
    @IBOutlet weak var webview: WKWebView!
    var urlString: String = ""
    var indicator = ActivityIndicatorService()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: ImageProvider.closeIcon, style: .plain, target: self, action: #selector(backAction))
        self.title = "Dashboard"
        webview.navigationDelegate = self
        if let url = URL(string: urlString) {
            let myRequest = URLRequest(url: url)
            webview.load(myRequest)
            self.startLoadingIndicator(indicator: indicator)
        }
    }
    
    @objc func backAction() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func qrCodeTapped(_ sender: Any) {
        self.backAction()
    }
}
extension DashboardViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Hide Sinner
        self.stopLoadingIndicator(indicator: indicator)
    }
}
