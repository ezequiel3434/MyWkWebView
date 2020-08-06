//
//  ViewController.swift
//  MyWkWebView
//
//  Created by Ezequiel Parada Beltran on 06/08/2020.
//  Copyright © 2020 Ezequiel Parada. All rights reserved.
//

import UIKit
import WebKit

final class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var backBtn: UIBarButtonItem!
    @IBOutlet weak var fowardBtn: UIBarButtonItem!
    
    // MARK: -Privates
    private let searchBar = UISearchBar()
    private var webView: WKWebView!
    private let refreshCOntrol = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // NAvigation buttons
        backBtn.isEnabled = false
        fowardBtn.isEnabled = false
        
        
        
        
        // Search bar
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        // WebView
        let webViewPrefers = WKPreferences()
        webViewPrefers.javaScriptEnabled = true
        webViewPrefers.javaScriptCanOpenWindowsAutomatically = true
        
        let webViewConf = WKWebViewConfiguration()
        webViewConf.preferences = webViewPrefers
        
        webView = WKWebView(frame: view.frame, configuration: webViewConf)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        // Refresh control
        
        refreshCOntrol.addTarget(self, action: #selector(reload), for: .valueChanged)
        webView.scrollView.addSubview(refreshCOntrol)
        view.bringSubviewToFront(refreshCOntrol)
        
        load(url: "https://www.google.com")
        
    }

    @IBAction func backBtnAction(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func fowardBtnAction(_ sender: Any) {
        webView.goForward()
    }
    
    //MARK: Private methods
    private func load( url:String ){
        print("hola")
        webView.load(URLRequest(url: URL(string: url)!))
    }
    @objc private func reload(){
        webView.reload()
    }
    
}

// MARK: -UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

// MARK: -WKNavigationDelegate

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        refreshCOntrol.endRefreshing()
        backBtn.isEnabled = webView.canGoBack
        fowardBtn.isEnabled = webView.canGoForward
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        refreshCOntrol.beginRefreshing()
    }
    
}
