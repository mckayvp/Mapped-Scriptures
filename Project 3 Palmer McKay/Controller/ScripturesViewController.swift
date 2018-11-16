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
    var backName = ""
    var mapplaces = [GeoPlace]()
    // mapConfiguration class with all geoplaces, pass with prepareForSegue
    var map = Map()
    
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
        
        if (chapter < 1) {
            title = "\(backName)"
        } else {
            title = "\(backName) \(chapter)"
        }
        configureDetailViewController()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookID, chapter: chapter)
        
        if let mapVC = mapViewController {
            print("mapVC")
            mapVC.configureMap(geoplaces)
        }
        
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
        
        print("-------geoplaces--------")
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
                    if let mapVC = mapViewController {
                        print("------mapVC------")
                        mapplaces.append(GeoDatabase.sharedGeoDatabase.geoPlaceForId(geoplaceId)!)
                        mapVC.configureMap(mapplaces)
                        print("scrips calling mapConfiguration")
                    }
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
        if let splitVC = splitViewController { //if in split view controller, map is visible
            if let navVC = splitVC.viewControllers.last as? UINavigationController {
                mapViewController = navVC.topViewController as? MapViewController
            }
        } else {
            mapViewController = nil
        }
    }
    
}
