//
//  AppDelegate.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/7/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    private struct StoryBoard {
        static let DetailVCIdentifier = "DetailVC"
        static let MainStoryBoardName = "Main"
    }

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let splitVC = window!.rootViewController as? UISplitViewController {
            splitVC.delegate = self
        }
        
        
        return true
    }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
//    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
//
//        if let navVC = primaryViewController as? UINavigationBar {
//            for controller in navVC.viewControllers {
//                if controller.restorationIdentifier == Storyboard.DetailVCIdentifier {
//                    return controller
//                }
//            }
//        }
//
//        let storyboard = UIStoryboard(name: storyboard.MainStoryboardName, bundle: nil)
//        let detailView = storyboard.instantiateViewController(withIdentifier:
//            StoryBoard.DetailVCIdentifier)
//    
//          return detailView
//    }
}

