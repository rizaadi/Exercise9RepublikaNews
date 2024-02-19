//
//  BrowserView.swift
//  Exercise9RepublikaNews
//
//  Created by Riza Adi Kurniawan on 19/02/24.
//

import SwiftUI
import WebKit

struct BrowserView: View {
    let url: URL
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            
            WebView(url: url, isLoading: $isLoading)
                .edgesIgnoringSafeArea(.all)
            if isLoading {
                ProgressView()
            }
            
        }
        
    }
}
struct WebView : UIViewRepresentable {
    let url: URL
    @Binding var isLoading: Bool
    
    func makeUIView(context: Context) -> WKWebView {
        let wkwebView = WKWebView()
        let request = URLRequest(url: url)
        wkwebView.load(request)
        return wkwebView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        init(parent: WebView) {
            self.parent = parent
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
    }
}

#Preview {
    BrowserView(url: URL(string: "https://www.rizaadikurniawan.com/")!)
}
