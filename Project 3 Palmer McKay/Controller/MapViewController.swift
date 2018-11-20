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
    
    var geoplacesArray = [GeoPlace]()
    
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
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Initial map view
        let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(40.2506, -111.65247),
                                 fromEyeCoordinate: CLLocationCoordinate2DMake(40.2306, -111.65247),
                                 eyeAltitude: 500)
        
        mapView.setCamera(camera, animated: true)
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
    
    
    // MARK: - Helpers
    
    func configureMap(_ geoplaces: [GeoPlace], _ mapTitle: String, _ isFromScrips: Bool) {
        geoplacesArray.removeAll()
        removePins()
        // https://www.hackingwithswift.com/example-code/language/how-to-remove-duplicate-items-from-an-array
        let uniquePlaces = geoplaces.removingDuplicates()
        for place in uniquePlaces {
            let annotation = MKPointAnnotation()
    
            annotation.coordinate = CLLocationCoordinate2DMake(place.latitude, place.longitude)
            annotation.title = place.placename
    
            mapView.addAnnotation(annotation)
            
            geoplacesArray.append(place)
        }
        
        // Move map to pin(s)
        if (uniquePlaces.count < 1) {
            // nothing to do with the map
        }
        else if (uniquePlaces.count == 1) { // Just one pin
            title = mapTitle
            let camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(geoplacesArray[0].latitude,
                                                                                 geoplacesArray[0].longitude),
                                     fromEyeCoordinate: CLLocationCoordinate2DMake(geoplacesArray[0].viewLatitude,
                                                                                geoplacesArray[0].viewLongitude),
                                     eyeAltitude: geoplacesArray[0].viewAltitude)
            
            mapView.setCamera(camera, animated: true)
        } else { // multiple to show, show by region
            title = mapTitle
            let center = CLLocationCoordinate2DMake(geoplacesArray[0].latitude,
                                                    geoplacesArray[0].longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
            let viewRegion = MKCoordinateRegion(center: center, span: span)
    
            mapView.setRegion(viewRegion, animated: true)
    
            mapView.showAnnotations(mapView.annotations, animated: true) //Show all annotations from viewDidLoad in rectangular view
        }
    }
    
    func removePins() {
        let allAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(allAnnotations)
    }
    
}


// MARK: - Extensions

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
