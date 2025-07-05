//
//  GIFView.swift
//  Outfiter
//
//  Created by Macky on 5/07/25.
//

import SwiftUI
import WebKit

struct GIFView: UIViewRepresentable {
    let gifName: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .clear
        webView.isOpaque = false
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let path = Bundle.main.path(forResource: gifName, ofType: "gif") {
            let data = try? Data(contentsOf: URL(fileURLWithPath: path))
            let base64String = data?.base64EncodedString() ?? ""
            let html = """
            <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <style>
                    body {
                        margin: 0;
                        padding: 0;
                        background-color: transparent;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        height: 100vh;
                    }
                    img {
                        max-width: 100%;
                        max-height: 100%;
                    }
                </style>
            </head>
            <body>
                <img src="data:image/gif;base64,\(base64String)" />
            </body>
            </html>
            """
            
            uiView.loadHTMLString(html, baseURL: nil)
        }
    }
}
