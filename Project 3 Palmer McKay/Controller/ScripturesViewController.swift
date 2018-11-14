//
//  ScripturesViewController.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/8/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController, WKNavigationDelegate {
    
    // MARK: - Properties
    var bookID = 101
    var chapter = 2
    // mapConfiguration class with all geoplaces, pass with prepareForSegue
    
    // MARK: - Private Properties
    
    private weak var mapViewController: MapViewController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - View Controller Lifecycles
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureDetailViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "\(chapter)"
        configureDetailViewController()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookID, chapter: chapter)
        
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
        
        print(geoplaces)
    }
    
    // MARK: - Navigation Delegate
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let path = navigationAction.request.url?.absoluteString {
            let baseUrl = ScriptureRenderer.Constant.baseUrl
            
            if path.hasPrefix(baseUrl) {
                if let geoplaceId = Int(path.substring(fromOffset: baseUrl.count)) {
                    // NEEDSWORK: focus on geoplaceID
                    print("Focusing on geoplace \(geoplaceId)")
                }
                if mapViewController == nil {
                    print("There is no map view controller")
                } else {
                    print("There is a map view controller")
                }
                
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    // MARK: - Helpers
    
    private func configureDetailViewController() {
        if let splitVC = splitViewController { //if in split view controller
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapViewController
            }
        } else {
            mapViewController = nil
        }
    }
}
