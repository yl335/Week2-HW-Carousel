//
//  PhotoDetailViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/17/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var actionMenuView: UIView!
    
    let zoomKey = "zoom"
    let scrollKey = "scroll"
    
    var autoHideMenu:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var screenHeight = UIScreen.mainScreen().bounds.size.height
        actionMenuView.frame.origin = CGPointMake(0, screenHeight)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(true, forKey: zoomKey)
        defaults.setBool(true, forKey: scrollKey)
        
        if autoHideMenu {
            showActionMenu(false, show:false)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if autoHideMenu {
            showActionMenu(false, show:false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressBackButton1(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func onPressBackButton2(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onPressBackButton3(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onPressShareButton(sender: AnyObject) {
        showActionMenu(true, show: true)
    }
    
    @IBAction func onPressCancelButton(sender: AnyObject) {
        showActionMenu(true, show: false)
    }
    
    @IBAction func unwindToSegue (segue : UIStoryboardSegue) {
        if segue.destinationViewController.isKindOfClass(PhotoDetailViewController) {
            let vc = segue.destinationViewController as! PhotoDetailViewController
            vc.autoHideMenu = true
        }
    }
    
    func showActionMenu(animated:Bool, show: Bool) {
        var height = actionMenuView.frame.size.height
        var adjustedHeight = show ? -height : height
        var screenHeight = UIScreen.mainScreen().bounds.size.height
        
        if (animated) {
            UIView.animateWithDuration(0.4, animations: {
                self.actionMenuView.frame = CGRectOffset(self.actionMenuView.frame, 0, adjustedHeight)
            })
        } else {
            self.actionMenuView.frame.origin = CGPointMake(0, screenHeight)
        }

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
