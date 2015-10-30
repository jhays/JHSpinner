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
        
        let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.orangeColor(), overlay:.Circular, overlayColor:UIColor.blackColor().colorWithAlphaComponent(0.6), fullCycleTime:4.0)
        
        view.addSubview(spinner)
        
//        delay(2.0) { () -> () in
//            spinner.dismiss()
//        }
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

