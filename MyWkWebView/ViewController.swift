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
        load(url: "http://www.google.com")
        
    }

    @IBAction func backBtnAction(_ sender: Any) {
    }
    
    @IBAction func fowardBtnAction(_ sender: Any) {
    }
    
    //MARK: Private methods
    private func load( url:String ){
        print("hola")
        webView.load(URLRequest(url: URL(string: url)!))
    }
    
}

// MARK: -UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
