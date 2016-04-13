//
//  ParksMapViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-03-01.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit
import MapKit

class ParksMapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet
    var mapView:MKMapView!

    var parks:[Park]!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "parkDetailSegueAgain", let pkMapAnnotation = sender!.annotation as? ParkMapPointAnnotation {
            let parkDetailVC = segue.destinationViewController as! ParksDetailViewController
            let selectedPark:Park = pkMapAnnotation.park
            
            parkDetailVC.park = selectedPark;
        }
        
        super.prepareForSegue(segue, sender: sender);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let portlandLocation = CLLocationCoordinate2D(latitude: 45.52, longitude: -122.681944)
        let portlandSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let portlandRegion:MKCoordinateRegion = MKCoordinateRegion(center: portlandLocation, span: portlandSpan)
        
        self.mapView.setRegion(portlandRegion, animated: true)
        
        let annotations:[MKPointAnnotation] = parks.map({ (park:Park) -> ParkMapPointAnnotation in
            return ParkMapPointAnnotation(park: park)
        })
        
        self.mapView.rotateEnabled = false
        self.mapView.addAnnotations(annotations)
        self.mapView.delegate = self
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        // @TODO replace with dequeueReusableAnnotationViewWithIdentifier
        // better performance by reusing an AnnotationView
        let annotationView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: nil)
        annotationView.pinTintColor = UIColor.init(red: 0.133, green: 0.545, blue: 0.133, alpha: 1)
        annotationView.enabled = true
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        self.performSegueWithIdentifier("parkDetailSegueAgain", sender: view)
    }
}
