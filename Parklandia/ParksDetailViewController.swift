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
    
    @IBOutlet
    var yearAcquiredLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = park.name
        self.yearAcquiredLabel.text = park.yearAcquired
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
