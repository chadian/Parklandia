//
//  ParkDetailListItem.swift
//  Parklandia
//
//  Created by Chad Carbert on 2016-05-18.
//  Copyright © 2016 Maple + Pine. All rights reserved.
//

import UIKit

class ParksDetailListItem: UIView {

    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame);

        label.text = String(arc4random_uniform(5)) + "Lets get this going"
        label.sizeToFit()
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
