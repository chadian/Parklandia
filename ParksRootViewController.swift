//
//  ParksRootViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-02-21.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit

class ParksRootViewController: UIViewController {

    @IBOutlet
    var containerView:UIView!

    @IBOutlet
    var segmentedControl:UISegmentedControl!
    
    var viewControllerIdentifiers = ["parkListView", "parkMapView"];
    
    @IBAction func segmentedControlAction(sender: UISegmentedControl!) {
        
        let segmentIndex = sender.selectedSegmentIndex;

        if let vc:UIViewController = storyboard?.instantiateViewControllerWithIdentifier(viewControllerIdentifiers[segmentIndex]) {
            self.addChildViewController(vc)
            vc.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
            self.containerView.addSubview(vc.view)
            vc.didMoveToParentViewController(self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
