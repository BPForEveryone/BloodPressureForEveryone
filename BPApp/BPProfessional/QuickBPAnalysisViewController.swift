//
//  QuickBPAnalysisViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class QuickBPAnalysisViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Table Fields
    @IBOutlet weak var genderControl: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var unitSelection: UISegmentedControl!
    @IBOutlet weak var systolicTextField: UITextField!
    @IBOutlet weak var diastolicTextField: UITextField!
    
    // Analyze Navigation Button Reference (for disabling if the fields are left empty)
    @IBOutlet var analyzeButton: UIBarButtonItem!
    
    // Globals storing data to be passed on
    var height: Height?
    var gender: Patient.Sex = Patient.Sex.male
    var age: Int = -1
    var systolicBP: Int = -1
    var diastolicBP: Int = -1
    var resetFlag = false;

    var readingDiagnosis: String = "We could not determine an analysis based on your patient data. Please double check your patient information and try again!"

    // Preset Interpretations
    let stage2HTN = "This patient has stage 2 hypertension and is over the 95th percentile + 12 mmHg. This patient needs to take immediate action and drastic life changes to improve personal health to combat this high BP."
    let stage1HTN = "This patient has stage 1 hypertension and is between the 95th percentile and the 95th percentile + 12 mmH. This patient needs to to have an action plan to improve personal health to combat this high BP."
    let elevatedBP = "This patient has stage 2 hypertension and between the 90th and 95th percentiles. This patient needs to look into incorporating small life changes (ie. healthy diet, more exercise) to handle this elevated BP."
    let normalBP = "This patient is within normal BP ranges, ie. < 90th percentile. They should still continue to live a healthy lifestyle, especially if they are older or have previously had hypertension."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        if(resetFlag){
//            resetFlag = false;
//            resetView();
//        }
//    }
    
    func hideKeyboard() {
        tableView.endEditing(true)
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
        
        heightTextField.reloadInputViews()
    }
    
//    func resetView() {
//        genderControl.selectedSegmentIndex = 0
//        ageTextField.text = ""
//        heightTextField.text = ""
//        systolicTextField.text = ""
//        diastolicTextField.text = ""
//    }
    
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
    
    // Disable or grey out Analyze Navigation UIBarButtonItem if
    // fields are left empty /or invalid
    @IBAction func analyzeOnPress(_ sender: UIBarButtonItem) {
   
        self.gender = (genderControl.selectedSegmentIndex == 0) ? Patient.Sex.male : Patient.Sex.female;
        
        if self.heightTextField.keyboardType == UIKeyboardType.decimalPad {
            self.height = Height(heightInMeters: Double(self.heightTextField.text!)!)
        }
        
        guard let _ = self.height as Height! else {
            return
        }


        // Age Check: age field must not be empty
        guard let ageString: String = ageTextField.text, !(ageTextField.text?.isEmpty)! else {
            print("Age is null or 0")
            return
        }
        
        self.age = Int(ageString)!

        guard let systolicBPString: String = systolicTextField.text, !(systolicTextField.text?.isEmpty)! else {
            return
        }
        
        self.systolicBP = Int(systolicBPString)!
        
        guard let diastolicBPString: String = diastolicTextField.text, !(diastolicTextField.text?.isEmpty)! else {
            return
        }
        
        self.diastolicBP = Int(diastolicBPString)!

        if (self.age < 13) {
            // Do BP for children calculations based on table here
            // Note: This now follows the fifth report guidelines
            // QuickBPAnalysisViewController should use norms table here now
            // TODO: Use norms table here
            let currentDate = Date()
            let calendar = Calendar.current
            var dateComponents = DateComponents()
            dateComponents.year = calendar.component(.year, from: currentDate) - age
            let dateOfBirth = calendar.date(from: dateComponents)
            let currPatient = Patient(firstName: "Some", lastName: "Last", birthDate: dateOfBirth!,
                                      height: self.height!,
                                      sex: self.gender,
                                      bloodPressureMeasurements: [BloodPressureMeasurement(systolic: self.systolicBP, diastolic: self.diastolicBP, measurementDate: currentDate)!])
            let diastolicPercent95_12mmHg = currPatient?.norms.diastolic95plus
            let diastolicPercent95 = currPatient?.norms.diastolic95
            let diastolicPercent90 = currPatient?.norms.diastolic90
            let systolicPercent95_12mmHg = currPatient?.norms.systolic95plus
            let systolicPercent95 = currPatient?.norms.systolic95
            let systolicPercent90 = currPatient?.norms.systolic90
            if (systolicBP >= systolicPercent95_12mmHg! || diastolicBP >= diastolicPercent95_12mmHg!) {
                readingDiagnosis = stage2HTN
            } else if (systolicBP >= systolicPercent95! || diastolicBP >= diastolicPercent95!) {
                readingDiagnosis = stage1HTN
            } else if (systolicBP >= systolicPercent90! || diastolicBP >= diastolicPercent90!) {
                readingDiagnosis = elevatedBP
            } else {
                readingDiagnosis = normalBP
            }

        } else {
            // This is the adults and/or 13+ case
            if (systolicBP >= 140 || diastolicBP >= 90) {
                readingDiagnosis = stage2HTN
            } else if (systolicBP >= 130 || diastolicBP >= 80) {
                readingDiagnosis = stage1HTN
            } else if (systolicBP >= 120) {
                readingDiagnosis = elevatedBP
            } else {
                readingDiagnosis = normalBP
            }

        }

        self.performSegue(withIdentifier: "showBPAnalysisResults", sender: self)
    }

    // Pass relevant patient data through UINavigationController to BPAnalysisResultsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showBPAnalysisResults" {
                let navController = segue.destination as! UINavigationController
                let BPAnalysisResultsViewController = navController.topViewController as! BPAnalysisResultsViewController
                BPAnalysisResultsViewController.gender = self.gender
                BPAnalysisResultsViewController.age = self.age
                BPAnalysisResultsViewController.height = self.height
                BPAnalysisResultsViewController.readingDiagnosis = self.readingDiagnosis
                BPAnalysisResultsViewController.systolic = self.systolicBP
                BPAnalysisResultsViewController.diastolic = self.diastolicBP
            }
        }
    }
    
}
