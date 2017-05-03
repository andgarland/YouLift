//
//  PopUpViewController.swift
//  YouLift
//
//  Created by Andrew Garland on 4/27/17.
//  Copyright © 2017 rbuzby. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    var workoutAltered:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.finishLabel.text = "Would you like to end the workout?";
        
        if workoutAltered == nil {
            workoutAltered = false
        }
    }
    
    @IBOutlet weak var finishLabel: UILabel!
    
    
    @IBAction func resumeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func finishButton(_ sender: Any) {
        
        if workoutAltered! {
            //additional prompt
            
        }else{
            //save all the data
            //...
            
            //transition to initial start tab
            
            
        }
        
    }
    
}
