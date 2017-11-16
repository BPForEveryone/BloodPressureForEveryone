//
//  BPEAddPatientViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/26/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEAddPatientViewController: UIViewController {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    
    var patient: Patient!
    var dob: Date!;
    //var patients: PersistentPatients!
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
    }
    
    @IBAction func editingDOBTextField(_ sender: UITextField) {
        let dobPickerView: UIDatePicker = UIDatePicker();
        dobPickerView.datePickerMode = UIDatePickerMode.date;
        sender.inputView = dobPickerView;
        
        dobPickerView.addTarget(self, action: #selector(handleDOBPicker(sender:)), for: .valueChanged)
    }
    
    func handleDOBPicker(sender: UIDatePicker) {
        dob = sender.date;
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = DateFormatter.Style.medium;
        dateFormatter.timeStyle = DateFormatter.Style.none;
        dobTextField.text = dateFormatter.string(from: sender.date);
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func createPatient(_ sender: Any) {
        createNewPatient();
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil);
    }
    
    private func createNewPatient() {
        guard let firstname = firstnameTextField.text else {
            print("firstname not entered");
            return;
        }
        
        guard let lastname = lastNameTextField.text else {
            print("lastname not entered");
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
        
        let patientSex = (genderControl.selectedSegmentIndex == 0) ? Patient.Sex.male : Patient.Sex.female;
        let bpMeasurements : [BloodPressureMeasurement] = [];
        
        let height = (heightStr as NSString).doubleValue;
        
        patient = Patient(firstName: firstname, lastName: lastname, birthDate: patientDob, height: Height(heightInMeters: height), sex: patientSex, bloodPressureMeasurements: bpMeasurements);
        
        var patients = Config.patients
        patients.append(patient)
        Config.patients = patients
    }
}
