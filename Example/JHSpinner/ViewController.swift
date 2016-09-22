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
        
        view.backgroundColor = UIColor(patternImage:UIImage(named: "orbospherecom_tile")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.red, overlay:.roundedSquare, overlayColor:UIColor.black.withAlphaComponent(0.6), fullCycleTime:4.0, text:"Loading")

        //let spinner = JHSpinnerView.showDeterminiteSpinnerOnView(view)
        
        delay(6) { () -> () in
            spinner.dismiss()
        }
    }
    
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

