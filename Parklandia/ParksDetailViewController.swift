//
//  ParksDetailViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-03-10.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit
import MapKit

class ParksDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var park:Park!
    
    @IBOutlet
    var map:MKMapView!
    
    @IBOutlet
    var titleLabel:UILabel!
    
    @IBOutlet
    var table:UITableView!
    
    override func viewDidLoad() {
        title = park.name
        titleLabel.text = park.name
        
        map.region = MKCoordinateRegion(center: park.coord!, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        map.rotateEnabled = false
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        indexPath.indexAtPosition(0)
        
        let cell = UITableViewCell()
        cell.textLabel!.text = "Words words words"
        
        return cell
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
//        return park.details.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
