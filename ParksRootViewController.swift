//
//  ParksRootViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-02-21.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit
import MapKit

class ParksRootViewController: UIViewController {

    @IBOutlet
    var containerView:UIView!

    @IBOutlet
    var segmentedControl:UISegmentedControl!
    
    var parks:[Park] = [Park]()
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl!) {
        let segmentIndex = sender.selectedSegmentIndex;
        self.transitionToSegmentViewByIndex(segmentIndex);
    }
    
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
                        let parkLong:Double = item["loc"]!["lon"] as! Double
                        let parkLat:Double = item["loc"]!["lat"] as! Double
                        
                        // clean up parkName, remove whitespace
                        parkName = parkName?.stringByTrimmingCharactersInSet(
                            NSCharacterSet.whitespaceAndNewlineCharacterSet()
                        )
                        
                        parks.append(Park(
                            name: parkName,
                            long: parkLong,
                            lat: parkLat
                        ))
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
        
        self.transitionToSegmentViewByIndex(0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func transitionToSegmentViewByIndex(index: Int) -> UIViewController? {
        var viewControllerIdentifiers = ["parkListView", "parkMapView"];
        
        if let vc:UIViewController = storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[index]) {
            
            if index == 0 {
                if let vc = vc as? ParksListViewController {
                    vc.parks = self.parks
                }

            }
            
            if index == 1 {
                if let vc = vc as? ParksMapViewController {
                    vc.parks = self.parks
                }
                
            }
            
            self.addChildViewController(vc)
            vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
            self.containerView.addSubview(vc.view)
            vc.didMoveToParentViewController(self)
            
            return vc;
        }
        
        return nil;
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
