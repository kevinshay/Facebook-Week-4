//
//  photoViewController.swift
//  Facebook
//
//  Created by Kevin Shay on 2/26/15.
//  Copyright (c) 2015 Nico. All rights reserved.
//

import UIKit

class photoViewController: UIViewController {

    var image: UIImage!
    @IBOutlet weak var imageView: UIImageView!
    var startingImageCenter : CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      imageView.image = image

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonDidPress(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func imageDidPan(sender: UIPanGestureRecognizer) {
        var velocity = sender.velocityInView(view)
        
        var translation = sender.translationInView(view)
        
        
        if (sender.state == UIGestureRecognizerState.Began){
            startingImageCenter = imageView.center
            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            
           imageView.center = CGPoint(x: startingImageCenter.x, y: imageView.center.y + translation.y)
            
//            if(velocity < 0 ){
//                imageView.center.y = 600
//            }
            
        } else if (sender.state == UIGestureRecognizerState.Ended) {
            dismissViewControllerAnimated(true, completion: nil)
            
           
            
        }
    }
  

}
