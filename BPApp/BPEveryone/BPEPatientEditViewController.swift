//
//  BPEPatientEditViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/29/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEPatientEditViewController : UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var unitSelection: UISegmentedControl!
    
    var height: Height?
    var dob: Date!
    var patientId: Int = 0
    
    @IBAction func unitSystemChanged(_ sender: Any) {
        if self.unitSelection.selectedSegmentIndex == 1 {
            
            heightTextField.keyboardType = UIKeyboardType.alphabet
            
            let pickerView = UIPickerView()
            heightTextField.inputView = pickerView
            pickerView.delegate = self
            
            
        } else {
            
            heightTextField.keyboardType = UIKeyboardType.decimalPad
            heightTextField.inputView = nil
        }
        
        heightTextField.reloadInputViews()
    }
    
    // Exit without updating.
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    // Update the patient.
    @IBAction func updatePatient(_ sender: Any) {
        guard let firstName = firstNameTextField.text else {
            return
        }
        
        guard let lastName = lastNameTextField.text else {
            return
        }
        
        guard let patientDob = dob else {
            return
        }
        
        if self.heightTextField.keyboardType == UIKeyboardType.decimalPad {
            self.height = Height(heightInMeters: Double(self.heightTextField.text!)!)
        }
        
        guard let _ = self.height as Height! else {
            return
        }
        
        let patientSex = (sexSegmentedControl.selectedSegmentIndex == 0) ? Patient.Sex.male : Patient.Sex.female;
        
        let patient = Patient(
            firstName: firstName,
            lastName: lastName,
            birthDate: patientDob,
            height: Height(heightInMeters: self.height!.meters),
            sex: patientSex,
            bloodPressureMeasurements: Config.patients[patientId].bloodPressureMeasurements
        );
        
        Config.patients[patientId] = patient!
        
        dismiss(animated: true, completion: nil);
    }
    
    // Use a date picker for the date of birth field
    @IBAction func editingDOBTextField(_ sender: UITextField) {
        
        // Create date of birth picker.
        let dobPickerView: UIDatePicker = UIDatePicker();
        dobPickerView.datePickerMode = UIDatePickerMode.date;
        sender.inputView = dobPickerView;
        
        // Callback for handling picker.
        dobPickerView.addTarget(self, action: #selector(handleDOBPicker(sender:)), for: .valueChanged)
    }
    
    func handleDOBPicker(sender: UIDatePicker) {
        
        // Record birth date
        dob = sender.date
        
        // Display new birth date
        dobTextField.text = BirthDay.format(date: dob)
    }
    
    // Update the defaults of all the fields to that of the selected patient.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Grab patient we are editting.
        let patient = Config.patients[patientId]

        // Populate old date of birth so that update function works.
        self.dob = patient.birthDate

        // Set names
        firstNameTextField.text = patient.firstName
        lastNameTextField.text = patient.lastName

        // Set gender
        var selectedSegment: Int = 0
        if patient.sex == Patient.Sex.female {
            selectedSegment = 1
        }
        sexSegmentedControl.selectedSegmentIndex = selectedSegment

        // Birth date
        dobTextField.text = BirthDay.format(date: dob)

        // Height
        heightTextField.text = "\(patient.height.meters)"
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        // One component is the ft, the other component is the in
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        // Component 0 is the ft, component 1 is the inches.
        return component == 0 ? 7 : 12
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return component == 0 ? "\(row) ft" : "\(row) in"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        heightTextField.text = "\(pickerView.selectedRow(inComponent: 0)) ft \(pickerView.selectedRow(inComponent: 1)) in"
        self.height = Height(heightInFeet: Double(pickerView.selectedRow(inComponent: 0)) + Double(pickerView.selectedRow(inComponent: 1)) / 12.0)
    }
    
}
