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
    var mapTitle = ""
    var mapPlaces = [GeoPlace]()
    var map = Map()
    
    // MARK: - Private Properties
    
    private weak var mapViewController: MapViewController?
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var mapButton: UIBarButtonItem!
    
    // MARK: - Actions
    
    @IBAction func showMap(_ sender: UIBarButtonItem) {
        Map.sharedConfig.showMap = true
    }
    
    // MARK: - View Controller Lifecycles
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (Map.sharedConfig.hasMapButton) {
            mapButton.title = "Map"
        } else {
            mapButton.title = ""
        }
        
        configureDetailViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (chapter < 1) {
            mapTitle = "\(backName)"
            title = mapTitle
        } else {
            mapTitle = "\(backName) \(chapter)"
            title = mapTitle
        }
        configureDetailViewController()
        
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookID, chapter: chapter)
        
        if let mapVC = mapViewController {
            mapVC.configureMap(geoplaces, mapTitle, false)
        }
        
        webView.navigationDelegate = self
        webView.loadHTMLString(html, baseURL: nil)
    }
    
    // MARK: - Navigation Delegate
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let path = navigationAction.request.url?.absoluteString {
            let baseUrl = ScriptureRenderer.Constant.baseUrl
            
            if path.hasPrefix(baseUrl) {
                if let geoplaceId = Int(path.substring(fromOffset: baseUrl.count)) {
                    // focus on geoplaceID
                    if let mapVC = mapViewController {
                        mapPlaces.removeAll()
                        mapPlaces.append(GeoDatabase.sharedGeoDatabase.geoPlaceForId(geoplaceId)!)
                        mapTitle = mapPlaces[0].placename
                        mapVC.configureMap(mapPlaces, mapTitle, true)
                    }
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
