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
    var gender: String?
    var age: Int?
    var height: Double?
    var weight: String?
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
    
    // Prepare data before view loads
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.genderLabel.text = gender
        self.ageLabel.text = String(age!) + " yrs"
        // TODO: Create if statement for Imperial and Metric displays of height and weight, fix formatting
        self.heightLabel.text = String(height!) + " cm"
        self.weightLabel.text = weight
        self.BPReadingLabel.text = String(systolic!) + "/" + String(diastolic!) + " mmHg"
        self.BPInterpretationText.text = readingDiagnosis
    }
}

