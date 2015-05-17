//
//  EmailViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/17/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    let shareKey = "share"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: shareKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
