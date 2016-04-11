//
//  ParkMapAnnotationView.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-04-02.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit
import MapKit

class ParkMapPointAnnotation: MKPointAnnotation {
    
    var park:Park!
    
    init(park:Park!) {
        super.init()

        self.park = park;
        
        if let coordinate:CLLocationCoordinate2D = park.coord  {
            self.coordinate = coordinate
        }
    }

}
