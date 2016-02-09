//
//  ParksListViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2015-12-25.
//  Copyright © 2015 Maple + Pine. All rights reserved.
//

import UIKit

class ParksListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet
    var tableView: UITableView!
    
    var parks:[Park] = [Park]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let parkDataURL = NSURL(string: "http://api.civicapps.org/parks/")
            if let parkJSONData = NSData(contentsOfURL: parkDataURL!) {
                let parkJSON = try NSJSONSerialization.JSONObjectWithData(parkJSONData, options: [])
                
                if let parksArray = parkJSON["results"] as? [NSDictionary] {
                    
                    for item in parksArray {
                        parks.append(Park(name: item["Property"] as? String))
                    }
                }
            } else {
                print("That did not work")
            }
        }
        catch let JSONError as NSError {
            print("\(JSONError)")
        }
    }
    
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

//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ParkCell")! as UITableViewCell
//        cell.textLabel?.text = "Some Portland Park"//self.parks[indexPath.row].name
//        
//        return cell
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
