//
//  BPERecordBPViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/29/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPERecordBPViewController: UIViewController {
   
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var combinedBPLabel: UILabel!
    @IBOutlet weak var systolicSlider: UISlider!
    @IBOutlet weak var diastolicSlider: UISlider!
    
    // The id of the patient to change.
    var patientId: Int = 0
    
    func updateBPLabel() {
        combinedBPLabel.text = "\(Int(systolicSlider.value))/\(Int(diastolicSlider.value))"
    }
    
    @IBAction func systolicChanged(_ sender: Any) {
        updateBPLabel()
    }
    
    @IBAction func diastolicChanged(_ sender: Any) {
        updateBPLabel()
    }
    
    @IBAction func record(_ sender: Any) {
        
        let patient = Config.patients[self.patientId]
        
        // Add new measurement to patient.
        patient.bloodPressureMeasurements.append(
            BloodPressureMeasurement(
                systolic: Int(systolicSlider.value),
                diastolic: Int(diastolicSlider.value),
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
        
        let patient = Config.patients[patientId]
        let age = Calendar.current.dateComponents([.year], from: patient.birthDate, to: Date()).year ?? 0
        
        fullNameTextField.text = "\(patient.firstName) \(patient.lastName)"
        ageTextField.text = "\(age) years"
        heightTextField.text = "\(patient.heightInMeters) meters"
        
        super.viewDidLoad();
    }
}
