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
    }

}
