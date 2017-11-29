//
//  BPERecordBPViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/29/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPERecordBPViewController: UITableViewController {
    
    @IBOutlet weak var systolicTextField: UITextField!
    @IBOutlet weak var diastolicTextField: UITextField!
    
    // The id of the patient to change.
    var patientId: Int = 0
    
    @IBAction func record(_ sender: Any) {
        
        let patient = Config.patients[self.patientId]
        
        guard let _ = systolicTextField.text as String! else {
            return
        }
        
        guard let _ = diastolicTextField.text as String! else {
            return
        }
        
        guard let _ = Int(systolicTextField.text!) as Int! else {
            return
        }
        
        guard let _ = Int(diastolicTextField.text!) as Int! else {
            return
        }
        
        // Add new measurement to patient.
        patient.bloodPressureMeasurements.append(
            BloodPressureMeasurement(
                systolic: Int(systolicTextField.text!)!,
                diastolic: Int(diastolicTextField.text!)!,
                measurementDate: Date(timeIntervalSinceNow: TimeInterval())
            )!
        )
        
        // Save new patient data.
        Config.patients[self.patientId] = patient
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
}
