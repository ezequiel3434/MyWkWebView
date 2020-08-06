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
    private let baseUrl = "https://www.google.com"
    private let searchPath = "/search?q="
    
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
        webView.scrollView.keyboardDismissMode = .onDrag
        view.addSubview(webView)
        
        webView.navigationDelegate = self
        
        // Refresh control
        
        refreshCOntrol.addTarget(self, action: #selector(reload), for: .valueChanged)
        webView.scrollView.addSubview(refreshCOntrol)
        view.bringSubviewToFront(refreshCOntrol)
        
        load(url: baseUrl)
        
    }

    @IBAction func backBtnAction(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func fowardBtnAction(_ sender: Any) {
        webView.goForward()
    }
    
    //MARK: Private methods
    private func load( url:String ){
        
        var urlToLoad: URL!
        
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url){
            urlToLoad = url
        } else {
            urlToLoad = URL(string:"\(baseUrl)\(searchPath)\(url)")!
        }
        
        
        webView.load(URLRequest(url: urlToLoad))
    }
    @objc private func reload(){
        webView.reload()
    }
    
}

// MARK: -UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        load(url: searchBar.text ?? "")
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
        searchBar.text = webView.url?.absoluteString
    }
    
}
