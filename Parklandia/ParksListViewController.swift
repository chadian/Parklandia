//
//  ParksListViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2015-12-25.
//  Copyright © 2015 Maple + Pine. All rights reserved.
//

import UIKit

class ParksListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    /*

        IBOutlet & IBAction

    */

    @IBOutlet
    var tableView: UITableView!
    
    // data source
    var parks:[Park]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "parkDetailSegue" {
            let parkDetailVC = segue.destinationViewController as! ParksDetailViewController
            let selectedPark:Park? = self.parks[self.tableView.indexPathForSelectedRow!.row]
            
            parkDetailVC.park = selectedPark;
        }
        
        super.prepareForSegue(segue, sender: sender);
    }
    
    /*

        UITableView Protocols
    
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCellWithIdentifier("ParkCell", forIndexPath: indexPath)
        let park = parks[indexPath.row] as Park
        cell.textLabel?.text = park.name
            
        return cell
    }

}
