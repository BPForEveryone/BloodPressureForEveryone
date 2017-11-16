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
    
    var dob: Date!
    var patientId: Int = 0
    
    // Exit without updating.
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    // Update the patient.
    @IBAction func updatePatient(_ sender: Any) {
        guard let firstName = firstNameTextField.text else {
            print("Firstname not entered");
            return;
        }
        
        guard let lastName = lastNameTextField.text else {
            print("Lastname not entered");
            return;
        }
        
        guard let heightStr = heightTextField.text  else {
            print("height not entered");
            return;
        }
        
        guard let patientDob = dob else {
            print("dob not entered");
            return;
        }
        
        let patientSex = (sexSegmentedControl.selectedSegmentIndex == 0) ? Patient.Sex.male : Patient.Sex.female;
        let height = (heightStr as NSString).doubleValue
        
        let patient = Patient(
            firstName: firstName,
            lastName: lastName,
            birthDate: patientDob,
            height: Height(heightInMeters: height),
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

        // Height and weight
        heightTextField.text = patient.height.description
    }
}
