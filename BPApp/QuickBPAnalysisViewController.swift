//
//  QuickBPAnalysisViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class QuickBPAnalysisViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var bpTextField: UITextField!
    
    
    var ageOptions: [String] = []
    let heightOptions = [["1'", "2'", "3'", "4'", "5'", "6'"],
                         ["0\"","1\"","2\"","3\"","4\"","5\"","6\"","7\"","8\"","9\"","10\"","11\""]]
    
    var weightOptions: [String] = []
    var bpOptions = Array<Array<String>>()
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeOptions()
        
        let agePickerView = UIPickerView()
        agePickerView.delegate = self
        agePickerView.tag = 1
        agePickerView.selectRow(8, inComponent: 0, animated: true)
        ageTextField.inputView = agePickerView
        
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
            return heightOptions.count
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
            return heightOptions[component].count
        } else if pickerView.tag == 3 {
            return weightOptions.count
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
            return heightOptions[component][row]
        } else if pickerView.tag == 3 {
            return weightOptions[row]
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
            let feet = heightOptions[0][pickerView.selectedRow(inComponent: 0)]
            let inches = heightOptions[1][pickerView.selectedRow(inComponent: 1)]
            heightTextField.text = feet + " " + inches
        } else if pickerView.tag == 3 {
            weightTextField.text = weightOptions[row]
        } else if pickerView.tag == 4 {
            let systolic = bpOptions[0][pickerView.selectedRow(inComponent: 0)]
            let diastolic = bpOptions[1][pickerView.selectedRow(inComponent: 1)]
            bpTextField.text = systolic + "/" + diastolic
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}
