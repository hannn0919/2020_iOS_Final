//
//  WebView.swift
//  2020_iOS_Final
//
//  Created by Hannn on 2020/6/21.
//  Copyright © 2020 Hannn. All rights reserved.
//

import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
       
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
