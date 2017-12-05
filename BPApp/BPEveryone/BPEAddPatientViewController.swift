//
//  BPEAddPatientViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/26/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEAddPatientViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    @IBOutlet weak var unitSelection: UISegmentedControl!
    
    var height: Height?
    
    var dob: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    
    func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        // Exit without updating.
        dismiss(animated: true, completion: nil)
    }
    
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
        
        heightTextField.text = ""
        heightTextField.reloadInputViews()
    }
    
    @IBAction func editingDOBTextField(_ sender: UITextField) {
        let dobPickerView: UIDatePicker = UIDatePicker()
        dobPickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = dobPickerView
        
        dobPickerView.addTarget(self, action: #selector(handleDOBPicker(sender:)), for: .valueChanged)
    }
    
    func handleDOBPicker(sender: UIDatePicker) {
        dob = sender.date;
        let dateFormatter = DateFormatter();
        dateFormatter.dateStyle = DateFormatter.Style.medium;
        dateFormatter.timeStyle = DateFormatter.Style.none;
        dobTextField.text = dateFormatter.string(from: sender.date);
    }
    
    /*override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }*/
    
    @IBAction func createPatient(_ sender: Any) {
        
        guard let firstname = firstnameTextField.text else {
            return
        }
        
        guard let lastname = lastNameTextField.text else {
            return
        }
        
        guard let patientDob = dob else {
            return
        }
        
        let patientSex = (genderControl.selectedSegmentIndex == 0) ? Patient.Sex.male : Patient.Sex.female;
        let bpMeasurements : [BloodPressureMeasurement] = [];
        
        if self.heightTextField.keyboardType == UIKeyboardType.decimalPad {
            self.height = Height(heightInMeters: Double(self.heightTextField.text!)!)
        }
        
        guard let _ = self.height as Height! else {
            return
        }
        
        let patient: Patient! = Patient(firstName: firstname, lastName: lastname, birthDate: patientDob, height: Height(heightInMeters: self.height!.meters), sex: patientSex, bloodPressureMeasurements: bpMeasurements)
        
        var patients = Config.patients
        patients.append(patient)
        Config.patients = patients
        
        dismiss(animated: true, completion: nil)
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
