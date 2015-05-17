//
//  IntroViewController.swift
//  Carousel
//
//  Created by Sara Lin on 5/12/15.
//  Copyright (c) 2015 Sara Lin. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, UIScrollViewDelegate {

    let transitionManager = ScaleInTransitionManager()

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tileView: UIImageView!
    @IBOutlet weak var tileView2: UIImageView!
    @IBOutlet weak var tileView3: UIImageView!
    @IBOutlet weak var tileView4: UIImageView!
    @IBOutlet weak var tileView5: UIImageView!
    @IBOutlet weak var tileView6: UIImageView!
    
    var yOffsets : [Float] = [-290, -250, -405, -387, -493, -475]
    var xOffsets : [Float] = [-70, 35, 23, 75, -112, -73]
    var scales : [Float] = [0.9, 1.65, 1.5, 1.7, 1.7, 1.65]
    var rotations : [Float] = [-10, -10, 10, 10, 9, -10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        transformOnScroll(0, tileViews: [tileView, tileView2, tileView3, tileView4, tileView5, tileView6])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        println("prepare for segue")
        
        var destinationVC = segue.destinationViewController as! UIViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self.transitionManager
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offset = Float(scrollView.contentOffset.y)
        
        transformOnScroll(offset, tileViews: [tileView, tileView2, tileView3, tileView4, tileView5, tileView6])
    }
    
    func transformOnScroll(offset:Float, tileViews: [UIImageView]) {
        var view:UIImageView
        var x:CGFloat
        var y:CGFloat
        var scale:CGFloat
        var rotation:CGFloat
        
        for var index = 0; index < tileViews.count; ++index {
            y = CGFloat(convertValue(offset, 0, 568, yOffsets[index], 0))
            x = CGFloat(convertValue(offset, 0, 568, xOffsets[index], 0))
            scale = CGFloat(convertValue(offset, 0, 568, scales[index], 1))
            rotation = CGFloat(convertValue(offset, 0, 568, rotations[index], 0)) * CGFloat(M_PI / 180)
            
            view = tileViews[index]
            view.transform = CGAffineTransformMakeTranslation(CGFloat(x), CGFloat(y))
            view.transform = CGAffineTransformScale(view.transform, CGFloat(scale), CGFloat(scale))
            view.transform = CGAffineTransformRotate(view.transform, CGFloat(rotation))
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
