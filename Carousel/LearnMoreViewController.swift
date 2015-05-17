//
//  LearnMoreViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/17/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class LearnMoreViewController: UIViewController {

    @IBOutlet weak var photoCheckBox: UIImageView!
    @IBOutlet weak var scrollCheckBox: UIImageView!
    @IBOutlet weak var shareCheckBox: UIImageView!
    
    let learnKeys = ["zoom", "scroll", "share"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkLearnings()
    }
    
    override func viewDidAppear(animated: Bool) {
        checkLearnings()
    }
    
    func checkLearnings() {
        var checkBoxes = [photoCheckBox, scrollCheckBox, shareCheckBox]
        let defaults = NSUserDefaults.standardUserDefaults()
        
        for i in 0...2 {
            if (defaults.boolForKey(learnKeys[i])) {
                checkBoxes[i].hidden = false
            }
            else {
                checkBoxes[i].hidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressCloseButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
