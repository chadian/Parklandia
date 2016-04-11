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
    
    init(name: String?, long: Double?, lat: Double?) {
        self.name = name
        
        if let long:Double = long, lat:Double = lat {
            self.coord = CLLocationCoordinate2D(latitude: lat, longitude: long)
        }
    }
}
