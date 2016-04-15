//
//  Park.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-02-02.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit
import MapKit

struct Park {
    var name: String?
    var coord:CLLocationCoordinate2D?
    var ownedAcres:Double?
    var unownedAcres:Double?
    var yearAcquired:String?
    var amenities:[String]?
    
    init(name: String, long: Double?, lat: Double?, ownedAcres:Double?, unownedAcres:Double?, yearAcquired:String?, amenities:[String]?) {
        // name
        self.name = name
        
        // location
        if let long:Double = long, lat:Double = lat {
            self.coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
        
        // acres
        self.ownedAcres = ownedAcres
        self.unownedAcres = unownedAcres
        
        // history
        self.yearAcquired = yearAcquired
        
        // amenities
        self.amenities = amenities
    }
}
