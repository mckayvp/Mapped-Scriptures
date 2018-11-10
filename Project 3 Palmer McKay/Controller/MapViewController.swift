//
//  MapViewController.swift
//  Project 3 Palmer McKay
//
//  Created by McKay Palmer on 11/9/18.
//  Copyright © 2018 McKay Palmer. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    
    
    // MARK: - Constants
    
    private struct Constant {
        static let AnnotationIdentifier = "MapPin"
    }
    
    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    // MARK: - View Controller Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let splitVC = splitViewController {
            navigationItem.leftItemsSupplementBackButton = true
            navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem    
        }
        
        mapView.register(MKPinAnnotationView.self,
                         forAnnotationViewWithReuseIdentifier:
                            Constant.AnnotationIdentifier)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2DMake(40.2506, -111.65247)
        annotation.title = "Tanner Building"
        annotation.subtitle = "BYU Campus"
        
        mapView.addAnnotation(annotation)
    }
    
    
    // MARK: - Map View Delegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = mapView.dequeueReusableAnnotationView(withIdentifier:
            Constant.AnnotationIdentifier,
                                                         for: annotation)
        
        if let pinView = view as? MKPinAnnotationView {
            pinView.canShowCallout = true
            pinView.animatesDrop = true
            pinView.pinTintColor = .blue 
        }
        
        return view
    }
}
