//
//  BPEAddPatientViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/26/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEAddPatientViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    
    var patient: Patient!
    var patients = Config.patients
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
    }
    
    @IBAction func createFromBar(_ sender: Any) {
        
        dismiss(animated: true, completion: nil);
    }
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    
}
