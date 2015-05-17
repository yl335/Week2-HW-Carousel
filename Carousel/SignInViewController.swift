//
//  SignInViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/12/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //original view location
    var originalSignInCenter: CGPoint!
    var originalFormCenter: CGPoint!
    
    //hardcoded email/pwd
    let emailStr = "q"
    let passwordStr = "w"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        originalSignInCenter = signInView.center
        originalFormCenter = formView.center
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPressBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
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
                var alertView = UIAlertView(
                    title: "Loading...",
                    message: "\n\n\n",
                    delegate: self,
                    cancelButtonTitle: nil)
                var loading = UIActivityIndicatorView()
                loading.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
                loading.hidesWhenStopped = true
                loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
                alertView.setValue(loading, forKey: "accessoryView")
                loading.startAnimating()
                alertView.show()
                
                delay(2, {
                    self.performSegueWithIdentifier("signInSegue", sender: nil)
                    alertView.dismissWithClickedButtonIndex(0, animated: true)
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
        var formOffset:CGFloat = show ? 70 : 0
        var signInOffset = show ? (kbSize.height - 10) : 0
            
        UIView.animateWithDuration(
            animationDuration,
            delay: 0.0,
            options: UIViewAnimationOptions(UInt(animationCurve << 16)),
            animations: {
                self.formView.center.y = self.originalFormCenter.y - formOffset
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
