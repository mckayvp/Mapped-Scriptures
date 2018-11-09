//
//  MapViewController.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/9/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

class MapViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem    
        }
    }
}
