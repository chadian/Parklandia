//
//  ParksMapViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-03-01.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit
import MapKit

class ParksMapViewController: UIViewController {

    @IBOutlet
    var mapView:MKMapView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let portlandLocation = CLLocationCoordinate2D(latitude: 45.52, longitude: -122.681944)
        let portlandSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        let portlandRegion:MKCoordinateRegion = MKCoordinateRegion(center: portlandLocation, span: portlandSpan)
        
        mapView.setRegion(portlandRegion, animated: true)
//        mapView.setCenterCoordinate(portlandLocation, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
