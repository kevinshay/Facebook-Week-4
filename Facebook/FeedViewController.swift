//
//  FeedViewController.swift
//  Facebook
//
//  Created by Nicolas Bories on 2/4/15.
//  Copyright (c) 2015 Nico. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
   
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var homeFeedImage: UIImageView!
    @IBOutlet weak var wedding1: UIImageView!
    var isPresenting: Bool = true
    var duration :NSTimeInterval!
    var blackView: UIView!
    var endFrame: CGRect!
    var finalFrame: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        duration = 0.5
        scrollView.contentSize =
        homeFeedImage.frame.size

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        var destinationViewController = segue.destinationViewController as photoViewController
        

        
       //custom transition
        var destinationVC = segue.destinationViewController as photoViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = self
        destinationVC.image = wedding1.image
        
        
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        isPresenting = false
        return self
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        // The value here should be the duration of the animations scheduled in the animationTransition method
        return duration
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        println("animating transition")
        var containerView = transitionContext.containerView()
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        
        var movingImageView = UIImageView(image: wedding1.image)
        movingImageView.contentMode = wedding1.contentMode
        movingImageView.clipsToBounds = wedding1.clipsToBounds
        
        finalFrame = containerView.convertRect(wedding1.frame, fromView:scrollView)
        movingImageView.frame = finalFrame
        
        var height = (320 * movingImageView.image!.size.height) / movingImageView.image!.size.width
        endFrame = CGRect(x: 0, y: (view.frame.size.height - height) / 2, width: 320, height: height)
        var window = UIApplication.sharedApplication().keyWindow!
        window.addSubview(movingImageView)
        
        if (isPresenting) {
          
            var destinationVC = toViewController as photoViewController
           
            blackView = UIView(frame: fromViewController.view.frame)
            blackView.backgroundColor = UIColor.blackColor()
            blackView.alpha = 0
            containerView.addSubview(blackView)
            
            containerView.addSubview(toViewController.view)
            toViewController.view.alpha = 0
            
            UIView.animateWithDuration(duration, animations: { () -> Void in
                toViewController.view.alpha = 1
                movingImageView.frame = self.endFrame
                self.blackView.alpha = 1

                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)
                    movingImageView.removeFromSuperview()

            }
        } else {
//            var dismissFrame = containerView.convertRect(movingImageView.frame, fromView:photoViewController)            movingImageView.frame = dismissFrame
            var destinationVC = fromViewController as photoViewController
            movingImageView.frame = destinationVC.imageView.frame

            UIView.animateWithDuration(duration, animations: { () -> Void in
                fromViewController.view.alpha = 0
                movingImageView.frame = self.finalFrame
                }) { (finished: Bool) -> Void in
                    transitionContext.completeTransition(true)

                    fromViewController.view.removeFromSuperview()
                    movingImageView.removeFromSuperview()
                   
                    
                    
            }
        }
    }
    
  


    @IBAction func wedding1Tap(sender: AnyObject) {
        var imageView = sender.view as UIImageView
        wedding1 = imageView
        performSegueWithIdentifier("wedding1Segue", sender: self)
       
     
    }


}
