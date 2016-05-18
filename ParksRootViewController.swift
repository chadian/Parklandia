//
//  ParksRootViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-02-21.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit
import Alamofire

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

        Alamofire.request(.GET, "http://api.civicapps.org/parks")
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Unable to get data")
                    return
                }
                
                guard let parks = response.result.value!["results"] as? [AnyObject] else {
                    print("Results root not found")
                    return
                }
                
                for park in parks {
                    var parkName = park["Property"] as? String
                    // clean up parkName, remove whitespace
                    parkName = parkName?.stringByTrimmingCharactersInSet(
                        NSCharacterSet.whitespaceAndNewlineCharacterSet()
                    )
                    
                    
                    let parkLong:Double = park["loc"]!!["lon"] as! Double
                    let parkLat:Double = park["loc"]!!["lat"] as! Double
                    let ownedAcres:Double? = Double(park["OwnedAcres"] as! String)
                    let unownedAcres:Double? = Double(park["UnownedAcres"] as! String)
                    let yearAcquired:String = park["YearAcquired"] as! String
                    let amenities:Array? = park["amenities"] as? [String]

                    self.parks.append(Park(
                        name: parkName!,
                        long: parkLong,
                        lat: parkLat,
                        ownedAcres: ownedAcres,
                        unownedAcres: unownedAcres,
                        yearAcquired: yearAcquired,
                        amenities: amenities
                    ))
                }
                
                self.parks.sortInPlace { (park1, park2) -> Bool in
                    return park1.name < park2.name
                }
                
                self.transitionToSegmentViewByIndex(0);
        }
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
}
