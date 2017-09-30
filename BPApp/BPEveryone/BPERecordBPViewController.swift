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
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var confirmPatientSwitch: UISwitch!
    @IBOutlet weak var combinedBPLabel: UILabel!
    
    @IBOutlet weak var bpSystolicDiastolicPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
}
