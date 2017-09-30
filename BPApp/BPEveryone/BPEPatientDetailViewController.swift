//
//  BPEPatientDetailViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/29/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit
import os.log

class BPEPatientDetailViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var analysisGroupLabel: UILabel! //Children vs Adults
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var lastBPDateTimeLabel: UILabel!
    @IBOutlet weak var lastBPMeasurmentLabel: UILabel!
    @IBOutlet weak var lastBPPercentileLabel: UILabel!
    @IBOutlet weak var lastBPReccomendationsLabel: UITextView!
    
    @IBAction func back(_ sender: Any) {
    }
    
    //May not be needed... 'Edit Patient' button linked to EditPatient View in Storyboard.
    @IBAction func editPatient(_ sender: Any) {
        
    }
    
    //May not be needed... 'Record BP!' button linked to RecordBP View in Storyboard.
    @IBAction func recordNewBP(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
}
