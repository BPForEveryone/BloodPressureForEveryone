//
//  BPAnalysisResultsViewController.swift
//  BPForProfessionals
//
//  Created by Andrew Hu on 9/28/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPAnalysisResultsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Patient Data from Patient Object and Supplementary Data
    var age: Int?
    var readingDiagnosis: String?
    var patient: Patient?
    
    // Navigation Bar Handlers
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
//        if let presenter = presentingViewController as? QuickBPAnalysisViewController {
//            //clear inputs
//            presenter.resetFlag = true
//        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // Table Cell Elements
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var BPReadingLabel: UILabel!
    @IBOutlet var BPInterpretationText: UITextView!
    
    // Prepare data before view loads
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.genderLabel.text = (self.patient?.sex == Patient.Sex.male) ? "Male" : "Female";
        self.ageLabel.text = String(self.age!) + " yrs"
        // TODO: Create conditional statement for Imperial and Metric display and fix formatting
        self.heightLabel.text = String(format: "%.2f m", (self.patient?.height.meters)!)
        // Weight is not used in the fifth report
        self.BPReadingLabel.text = String(describing: self.patient?.bloodPressureMeasurements[0].systolic) + "/" + String(describing: self.patient?.bloodPressureMeasurements[0].diastolic) + " mmHg"
        self.BPInterpretationText.text = readingDiagnosis
    }
    
    // Creates a Patient Object to pass to the BPProGraphViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showBPResultsGraph" {
                // Set the segue destination as the Navigation Controller and the BPProGraphView as the top view
                let navController = segue.destination as! UINavigationController
                let BPProGraphViewController = navController.topViewController as! BPProGraphViewController
                BPProGraphViewController.patient = self.patient
            }
        }
    }
}

