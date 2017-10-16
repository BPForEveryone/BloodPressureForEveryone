//
//  BPAnalysisResultsViewController.swift
//  BPForProfessionals
//
//  Created by Andrew Hu on 9/28/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPAnalysisResultsViewController: UITableViewController {
    
    // Data Entered By User (Patient Data)
    var age: String?
    var readingDiagnosis: String?
    var systolic: Int?
    var diastolic: Int?
    
    // Navigation Bar Handlers
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
    }
    
    // Table Cell Elements
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var BPReadingLabel: UILabel!
    @IBOutlet var BPInterpretationText: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (systolic != nil && diastolic != nil) {
            self.BPReadingLabel.text = String(systolic!) + "/" + String(diastolic!) + " mmHg"
        }
        self.BPInterpretationText.text = readingDiagnosis
    }
}

