//
//  QuickBPAnalysisViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class QuickBPAnalysisViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // Table Fields
    @IBOutlet weak var genderField: UISegmentedControl!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var bpTextField: UITextField!
    
    // Analyze Navigation Button Reference (for disabling if the fields are left empty)
    @IBOutlet var analyzeButton: UIBarButtonItem!
    
    // Picker Options
    let numSysImperial = UserDefaults.standard.value(forKey: "numSystem") as? Int == 0
    var ageOptions: [String] = []
    let heightOptions = [["1'", "2'", "3'", "4'", "5'", "6'"],
                         ["0\"","1\"","2\"","3\"","4\"","5\"","6\"","7\"","8\"","9\"","10\"","11\""]]
    var heightOptionsMetric = [["0m", "1m", "2m"], []]
    
    var weightOptions: [String] = []
    var weightOptionsMetric: [String] = []
    var bpOptions = Array<Array<String>>()
    
    // Globals storing data to be passed on
    var gender: String = ""
    var age: Int = -1
    var height: Double = 0.0
    var weight: String = ""
    var readingDiagnosis: String = "We could not determine an analysis based on your patient data. Please double check your patient information and try again!"
    var systolicBP: Int = -1
    var diastolicBP: Int = -1
    
    // Preset Interpretations
    let stage2HTN = "This patient has stage 2 hypertension and is over the 95th percentile + 12 mmHg. This patient needs to take immediate action and drastic life changes to improve personal health to combat this high BP."
    let stage1HTN = "This patient has stage 1 hypertension and is between the 95th percentile and the 95th percentile + 12 mmH. This patient needs to to have an action plan to improve personal health to combat this high BP."
    let elevatedBP = "This patient has stage 2 hypertension and between the 90th and 95th percentiles. This patient needs to look into incorporating small life changes (ie. healthy diet, more exercise) to handle this elevated BP."
    let normalBP = "This patient is within normal BP ranges, ie. < 90th percentile. They should still continue to live a healthy lifestyle, especially if they are older or have previously had hypertension."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeOptions()
        
        let agePickerView = UIPickerView()
        agePickerView.delegate = self
        agePickerView.tag = 1
        agePickerView.selectRow(8, inComponent: 0, animated: true)
        ageTextField.inputView = agePickerView
        
        if numSysImperial {
            let heightPickerView = UIPickerView()
            heightPickerView.delegate = self
            heightPickerView.tag = 2
            heightPickerView.selectRow(3, inComponent: 0, animated: true)
            heightTextField.inputView = heightPickerView
            
            let weightPickerView = UIPickerView()
            weightPickerView.delegate = self
            weightPickerView.tag = 3
            weightPickerView.selectRow(189, inComponent: 0, animated: true)
            weightTextField.inputView = weightPickerView
        } else {
            let heightPickerView = UIPickerView()
            heightPickerView.delegate = self
            heightPickerView.tag = 2
            heightPickerView.selectRow(1, inComponent: 0, animated: true)
            heightPickerView.selectRow(50, inComponent: 1, animated: true)
            heightTextField.inputView = heightPickerView
            
            let weightPickerView = UIPickerView()
            weightPickerView.delegate = self
            weightPickerView.tag = 3
            weightPickerView.selectRow(79, inComponent: 0, animated: true)
            weightTextField.inputView = weightPickerView
        }
        
        let bpPickerView = UIPickerView()
        bpPickerView.delegate = self
        bpPickerView.tag = 4
        bpPickerView.selectRow(30, inComponent: 0, animated: true)
        bpPickerView.selectRow(20, inComponent: 1, animated: true)
        bpTextField.inputView = bpPickerView
        
    }
    
    func initializeOptions() {
        for i in 1...100 {
            ageOptions.append("\(i) yrs")
        }
        for i in 1...500 {
            weightOptions.append("\(i) lbs")
        }
        for i in 1...230 {
            weightOptionsMetric.append("\(i) kg")
        }
        for i in 0...99 {
            heightOptionsMetric[1].append("\(i)cm")
        }
        
        var systolicOptions: [String] = []
        var diastolicOptions: [String] = []
        for i in 90...250 {
            systolicOptions.append("\(i)")
        }
        for i in 60...140 {
            diastolicOptions.append("\(i)")
        }
        bpOptions.append(systolicOptions)
        bpOptions.append(diastolicOptions)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        if pickerView.tag == 2 {
            if numSysImperial {
                return heightOptions.count
            } else {
                return heightOptionsMetric.count
            }
        }
        
        if pickerView.tag == 4 {
            return bpOptions.count
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return ageOptions.count
        } else if pickerView.tag == 2 {
            if numSysImperial {
                return heightOptions[component].count
            } else {
                return heightOptionsMetric[component].count
            }
        } else if pickerView.tag == 3 {
            if numSysImperial {
                return weightOptions.count
            } else {
                return weightOptionsMetric.count
            }
        } else if pickerView.tag == 4 {
            return bpOptions[component].count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return ageOptions[row]
        } else if pickerView.tag == 2 {
            if numSysImperial {
                return heightOptions[component][row]
            } else {
                return heightOptionsMetric[component][row]
            }
        } else if pickerView.tag == 3 {
            if numSysImperial {
                return weightOptions[row]
            } else {
                return weightOptionsMetric[row]
            }
        } else if pickerView.tag == 4 {
            return bpOptions[component][row]
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            ageTextField.text = ageOptions[row]
        } else if pickerView.tag == 2 {
            if numSysImperial {
                let feet = heightOptions[0][pickerView.selectedRow(inComponent: 0)]
                let inches = heightOptions[1][pickerView.selectedRow(inComponent: 1)]
                heightTextField.text = feet + " " + inches
            } else {
                let meters = heightOptionsMetric[0][pickerView.selectedRow(inComponent: 0)]
                let centimeters = heightOptionsMetric[1][pickerView.selectedRow(inComponent: 1)]
                heightTextField.text = meters + " " + centimeters
            }
        } else if pickerView.tag == 3 {
            if numSysImperial {
                weightTextField.text = weightOptions[row]
            } else {
                weightTextField.text = weightOptionsMetric[row]
            }
        } else if pickerView.tag == 4 {
            let systolic = bpOptions[0][pickerView.selectedRow(inComponent: 0)]
            let diastolic = bpOptions[1][pickerView.selectedRow(inComponent: 1)]
            bpTextField.text = systolic + "/" + diastolic
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func convertHeightToDouble(heightString: String) -> Double {
        if numSysImperial {
            let apostropheInd = heightString.index(of: "'")
            let quotationInd = heightString.index(of: "\"")
            let spaceInd = heightString.index(of: " ")
            let rangeFeet = heightString.startIndex..<apostropheInd
            let rangeInches = heightString.index(spaceInd!, offsetBy: 1)..<quotationInd
            return Double(heightString.substring(with: rangeFeet))! * 12.0 + Double(heightString.substring(with: rangeInches))!
        } else {
            //let spaceInd = heightString.index(of: " ")
            //let rangeCm = heightString.startIndex..<spaceInd
            //return Double(heightString.substring(with: rangeCm))!
            let meterInd = heightString.index(of: "m")
            let centimeterInd = heightString.index(of: "c")
            let spaceInd = heightString.index(of: " ")
            let rangeMeters = heightString.startIndex..<meterInd
            let rangeCentimeters = heightString.index(spaceInd!, offsetBy: 1)..<centimeterInd
            return Double(heightString.substring(with: rangeMeters))! * 100.0 + Double(heightString.substring(with: rangeCentimeters))!
        }
    }
    
    // Disable or grey out Analyze Navigation UIBarButtonItem if
    // fields are left empty /or invalid
    @IBAction func analyzeOnPress(_ sender: UIBarButtonItem) {
        print("Analyze pressed")
        
        self.gender = genderField.titleForSegment(at: genderField.selectedSegmentIndex)!
        
        // Age Check: age field must not be empty
        guard let ageString: String = ageTextField.text, !(ageTextField.text?.isEmpty)! else {
            print("Age is null or 0")
            return
        }
        self.age = Int(ageString.components(separatedBy: " ")[0])!
        
        // Height Check: height field must not be empty
        guard let heightString: String = heightTextField.text, !(heightTextField.text?.isEmpty)! else {
            print("Height is null or 0")
            return
        }
        self.height = convertHeightToDouble(heightString: heightString)
        print("\(height)")
        
        self.weight = weightTextField.text!
        
        // BP Check : BP field must not be empty
        guard let bpString: String = bpTextField.text, !(bpTextField.text?.isEmpty)! else {
            print("BP is null or 0")
            return
        }
        let bothBP: [String] = bpString.components(separatedBy: "/")
        self.systolicBP = Int(bothBP[0])!
        self.diastolicBP = Int(bothBP[1])!
        print("\(systolicBP), \(diastolicBP)")
        
        if (self.age < 13) {
            // Do BP for children calculations based on table here
            // Note: This now follows the fifth report guidelines
            // QuickBPAnalysisViewController should use norms table here now
            // TODO: Use norms table here
        } else {
            // This is the adolescents+ case
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
        
        print("Segue was performed successfully")
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
                BPAnalysisResultsViewController.weight = self.weight
                BPAnalysisResultsViewController.readingDiagnosis = self.readingDiagnosis
                BPAnalysisResultsViewController.systolic = self.systolicBP
                BPAnalysisResultsViewController.diastolic = self.diastolicBP
            }
        }
    }
    
}
