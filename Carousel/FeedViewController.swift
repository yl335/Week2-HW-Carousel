//
//  FeedViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/17/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    let learnKeys = ["zoom", "scroll", "share"]
    
    
    @IBOutlet weak var dismissBannerButton: UIButton!
    @IBOutlet weak var bannerButton: UIButton!
    @IBOutlet weak var bannerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        var checkedAll = (learnKeys.filter({
            return !defaults.boolForKey($0)
        }).count == 0) ? true : false
        
        if checkedAll {
            UIView.animateWithDuration(1, animations: {
                self.bannerButton.hidden = true
                self.bannerImage.hidden = true
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressDismissBannerButton(sender: AnyObject) {
        bannerButton.hidden = true
        bannerImage.hidden = true
        dismissBannerButton.hidden = true
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
