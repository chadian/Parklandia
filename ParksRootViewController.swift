//
//  ParksRootViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-02-21.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import Alamofire
import CoreData
import UIKit

class ParksRootViewController: UIViewController {

    @IBOutlet
    var containerView:UIView!

    @IBOutlet
    var segmentedControl:UISegmentedControl!
    
    var parks:[Park] = [Park]()
//    var parks = [NSManagedObject]()
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl!) {
        let segmentIndex = sender.selectedSegmentIndex;
        self.transitionToSegmentViewByIndex(segmentIndex);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.parks.sortInPlace { (park1, park2) -> Bool in
            return park1.name < park2.name
        }
        
        self.transitionToSegmentViewByIndex(0);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadParksData() {
        // retrieve from CoreData
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Park")
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            let managedParks = results as! [NSManagedObject]
            for managedPark in managedParks {
                parks.append(Park(
                    name: managedPark.valueForKey("name") as! String,
                    long: managedPark.valueForKey("long") as! Double,
                    lat: managedPark.valueForKey("lat") as! Double,
                    ownedAcres: managedPark.valueForKey("ownedAcres") as! Double,
                    unownedAcres: managedPark.valueForKey("unownedAcres") as! Double,
                    yearAcquired: managedPark.valueForKey("yearAquired") as! String,
                    amenities: managedPark.valueForKey("amenities") as! [String]
                ))
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // if no parks, download
        if (parks.count == 0) {
            downloadParksData()
        }
        
    }
    
    func pullSavedParksData() {
        
    }
    
    func downloadParksData() {
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
                    
                    
                    // TODO: Need to source into an NSManagedObject
                    // TODO: Need to check if this park's data already exists to avoid duplicates
                    // perhaps through the ID from the API, or hashing
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
        }
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
