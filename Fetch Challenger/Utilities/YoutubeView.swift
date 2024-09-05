//
//  WebView.swift
//  Fetch Challenger
//
//  Created by Jesse Monteiro Ferreira on 05/09/24.
//

import SwiftUI
import WebKit

struct YouTubeView: UIViewRepresentable {
    let video: String
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let demoURL = URL(string: video) else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: demoURL))
    }
}
