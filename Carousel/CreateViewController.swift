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
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var originalFormCenter: CGPoint!
    var originalButtonCenter: CGPoint!
    
    var emailStr = "q"
    var passwordStr = "w"
    
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
    
    @IBAction func onPressClick(sender: AnyObject) {
        if firstNameField.text.isEmpty {
            showAlert("First Name Required", messageStr: "Please enter your first name")
        } else if lastNameField.text.isEmpty {
            showAlert("Last Name Required", messageStr: "Please enter your last name")
        } else if emailField.text.isEmpty {
            showAlert("Email Required", messageStr: "Please enter your email address")
        } else if passwordField.text.isEmpty {
            showAlert("Password Required", messageStr: "Please enter your password")
        } 
        
        else {
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
                    self.performSegueWithIdentifier("createADropboxSeque", sender: nil)
                    alertView.dismissWithClickedButtonIndex(0, animated: true)
                })
            }
        }
    }
    
    @IBAction func onPressBackButton(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
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
