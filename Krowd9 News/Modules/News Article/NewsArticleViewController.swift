//
//  NewsArticleViewController.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit
import WebKit

class NewsArticleViewController: UIViewController, Storyboarded {

  @IBOutlet weak var progressBar: UIProgressView!

  private var webView: WKWebView?

  var articleUrl: URL?

  override func viewDidLoad() {
    super.viewDidLoad()

    let webConfig = WKWebViewConfiguration()
    webConfig.allowsInlineMediaPlayback = true
    webConfig.mediaTypesRequiringUserActionForPlayback = [.all]

    let webView = WKWebView(frame: view.bounds, configuration: webConfig)

    guard let url = articleUrl else { return }
    webView.load(URLRequest(url: url))
    webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)

    view.insertSubview(webView, belowSubview: progressBar)
    webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    self.webView = webView
  }

  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
      progressBar.setProgress(Float(webView?.estimatedProgress ?? 0), animated: true)

      if Float(webView?.estimatedProgress ?? 0) == 1 {
        UIView.animate(withDuration: 0.2, animations: {
          self.progressBar.alpha = 0
        })
      }
    }
  }

}
