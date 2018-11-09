//
//  ScripturesViewController.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/8/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit
import WebKit

class ScripturesViewController : UIViewController {
    
    var bookID = 101
    var chapter = 2
    
    private weak var mapViewController: MapViewController?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (html, geoplaces) = ScriptureRenderer.sharedRenderer.htmlForBookId(bookID, chapter: chapter)
        webView.loadHTMLString(html, baseURL: nil)
        
        print(geoplaces)
    }
    
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
