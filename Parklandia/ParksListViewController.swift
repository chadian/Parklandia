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
    var parks:[Park] = [Park]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let parkDataURL = NSURL(string: "http://api.civicapps.org/parks/")
            if let parkJSONData = NSData(contentsOfURL: parkDataURL!) {
                let parkJSON = try NSJSONSerialization.JSONObjectWithData(parkJSONData, options: [])
                
                if let parksDictionary = parkJSON["results"] as? [NSDictionary] {
                    
                    // create a Park from the json, add it to the parks array
                    for item in parksDictionary {
                        var parkName = item["Property"] as? String
                        
                        // clean up parkName, remove whitespace
                        parkName = parkName?.stringByTrimmingCharactersInSet(
                            NSCharacterSet.whitespaceAndNewlineCharacterSet()
                        )

                        parks.append(Park(name: parkName))
                    }
                    
                    // sort based on Park.name
                    parks.sortInPlace { (park1, park2) -> Bool in
                        return park1.name < park2.name
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
