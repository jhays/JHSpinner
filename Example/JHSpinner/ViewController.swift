//
//  ViewController.swift
//  JHSpinner
//
//  Created by JHays on 10/28/2015.
//  Copyright (c) 2015 JHays. All rights reserved.
//

import UIKit
import JHSpinner

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.orangeColor(), overlay:.Circular, overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.6), fullCycleTime:4.0)
        
        let spinner = JHSpinnerView.showDeterminiteSpinnerOnView(self.view)
        
        view.addSubview(spinner)
        
        spinner.progress = 0.2
        
//        UIView.animateWithDuration(2.0) { () -> Void in
//            spinner.progress = 0.8
//        }
        
        delay(0.1) { () -> () in
            spinner.progress = 0.3
        }
        
        delay(0.2) { () -> () in
            spinner.progress = 0.4
        }
        
        delay(0.3) { () -> () in
            spinner.progress = 0.5
        }
        
        delay(0.4) { () -> () in
            spinner.progress = 0.6
        }
    
        
        delay(1.0) { () -> () in
            spinner.progress = 1.0
        }
        
    }
    
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

