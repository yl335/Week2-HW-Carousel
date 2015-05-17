//
//  ScaleInTransitionManager.swift
//  Carousel
//
//  Created by Sara Lin on 5/16/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class ScaleInTransitionManager: NSObject, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
   
    var isPresenting: Bool = true
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {

        // The value here should be the duration of the animations scheduled in the animationTransition method
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        var toView = toViewController.view as UIView!
        var fromView = fromViewController.view as UIView!
        var animatedView:UIView
        
        let initialScale:CGFloat = 0.9
        let screenWidth:CGFloat = UIScreen.mainScreen().bounds.size.width
        let screenHeight:CGFloat = UIScreen.mainScreen().bounds.size.height
        
        if (isPresenting) {
            containerView.addSubview(toViewController.view)

            toViewController.view.alpha = 0
            animatedView = containerView.viewWithTag(1)!
            animatedView.alpha = 0
            animatedView.transform = CGAffineTransformScale(toViewController.view.transform, initialScale, initialScale)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toViewController.view.alpha = 1
                animatedView.alpha = 1
                animatedView.transform = CGAffineTransformScale(toViewController.view.transform, 1, 1)
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
            }
        } else {
            // Specify the initial position of the destination view.
            toView.frame = CGRectMake(-screenWidth, 0.0, screenWidth, screenHeight)
            toView.alpha = 1

            let window = UIApplication.sharedApplication().keyWindow
            window?.insertSubview(toView, aboveSubview: fromView)
            //containerView.addSubview(toView)
            
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                toView.frame = CGRectOffset(toView.frame, screenWidth, 0.0)
                fromView.frame = CGRectOffset(fromView.frame, screenWidth, 0.0)
                }) { (Finished) -> Void in
                    transitionContext.completeTransition(true)
                    fromViewController.view.removeFromSuperview()
            }
        }
    }
}
