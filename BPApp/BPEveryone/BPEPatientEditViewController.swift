//
//  BPEPatientEditViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/29/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEPatientEditViewController : UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    
    //Connected to both the bar button and button at the bottom of the page.
    @IBAction func updatePatient(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
}
