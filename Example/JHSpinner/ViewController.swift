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
        
      let spinner = JHSpinnerView.showOnView(view, spinnerColor:UIColor.red, overlay:.roundedSquare, overlayColor:UIColor.black.withAlphaComponent(0.6), fullCycleTime:2.55, text:nil)

      delay(6) { () -> () in
        spinner.dismiss()
      }
      
      //show sample determinite 
//      showSampleDeterminiteSpinner()
    }
  
  func showSampleDeterminiteSpinner() {
    let spinner = JHSpinnerView.showDeterminiteSpinnerOnView(view, spinnerColor: .white, backgroundColor: .black, fullCycleTime: 2.55, initialProgress: 0.0)
    
    delay(1) { () -> () in
      spinner.progress = 0.1
    }
    delay(2) { () -> () in
      spinner.progress = 0.3
    }
    delay(3) { () -> () in
      spinner.progress = 0.5
    }
    delay(4) { () -> () in
      spinner.progress = 0.7
    }
    delay(5) { () -> () in
      spinner.progress = 0.9
    }
    
    
    delay(6) { () -> () in
      spinner.dismiss()
    }

  }
  
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}

