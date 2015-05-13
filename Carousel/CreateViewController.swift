//
//  CreateViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/13/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {

    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var formView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    var originalFormCenter: CGPoint!
    var originalButtonCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        originalFormCenter = formView.center
        originalButtonCenter = buttonView.center
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressCheckbox(sender: AnyObject) {
        checkboxButton.selected = !checkboxButton.selected
    }
    
    @IBAction func onPressBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        animateShowHideKeyboard(notification, show: true)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        animateShowHideKeyboard(notification, show: false)
    }
    
    func animateShowHideKeyboard(
        notification: NSNotification!,
        show: Bool) {
            var userInfo = notification.userInfo!
            
            var kbSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue().size
            var durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey]as! NSNumber
            var animationDuration = durationValue.doubleValue
            var curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber
            var animationCurve = curveValue.integerValue
            
            //hardcoded offsets
            var formOffset:CGFloat = show ? 90 : 0
            var buttonOffset = show ? (kbSize.height - 35) : 0
            
            UIView.animateWithDuration(
                animationDuration,
                delay: 0.0,
                options: UIViewAnimationOptions(UInt(animationCurve << 16)),
                animations: {
                    self.formView.center.y = self.originalFormCenter.y - formOffset
                    self.buttonView.center.y = self.originalButtonCenter.y - buttonOffset
                    
                    return
                },
                completion: nil)
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
