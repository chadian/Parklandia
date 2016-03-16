//
//  ParksDetailViewController.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-03-10.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit

class ParksDetailViewController: UIViewController {

    var park:Park!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = park.name
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
