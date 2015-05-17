//
//  SignInViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/12/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var alertContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //original view location
    var originalSignInCenter: CGPoint!
    var originalScrollCenter: CGPoint!
    
    //hardcoded email/pwd
    let emailStr = "q"
    let passwordStr = "w"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        originalSignInCenter = signInView.center
        originalScrollCenter = scrollView.center
        
        // Dismiss keyboard when dragging down scrollView
        scrollView.keyboardDismissMode = .OnDrag
        
        overlayView.hidden = true
        alertContainerView.layer.cornerRadius = 5.0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(0.4, animations: {
            //self.view.hidden = false
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = Float(scrollView.contentOffset.y)
    }
    
    
    @IBAction func onPressBackButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func onPressSignIn(sender: AnyObject) {
        if emailField.text.isEmpty {
            showAlert("Email Required", messageStr: "Please enter your email address")
        } else if passwordField.text.isEmpty {
            showAlert("Password Required", messageStr: "Please enter your password")
        } else {
            if self.emailField.text != self.emailStr {
                self.showAlert("Valid Email Required", messageStr: "Please enter a valid email address")
            } else if self.passwordField.text != self.passwordStr {
                self.showAlert("Valid Password Required", messageStr: "Please enter a valid password")
            } else {
                view.endEditing(true)
                activityIndicator.hidesWhenStopped = true
                activityIndicator.startAnimating()
                UIView.animateWithDuration(0.2, animations: {
                    self.overlayView.hidden = false
                })
                
                delay(2, {
                    self.performSegueWithIdentifier("signInSegue", sender: nil)
                    self.overlayView.hidden = true
                })
            }
        }
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
        var scrollOffset:CGFloat = show ? 70 : 0
        var signInOffset = show ? (kbSize.height - 10 - scrollOffset) : 0
            
        UIView.animateWithDuration(
            animationDuration,
            delay: 0.0,
            options: UIViewAnimationOptions(UInt(animationCurve << 16)),
            animations: {
                self.scrollView.center.y = self.originalScrollCenter.y - scrollOffset
                self.signInView.center.y = self.originalSignInCenter.y - signInOffset
                
                return
            },
            completion: nil)
    }
    
    func showAlert(titleStr: String, messageStr: String) {
        var alertView = UIAlertView(
            title: titleStr,
            message: messageStr,
            delegate: self,
            cancelButtonTitle: "OK")
        alertView.show()
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
