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
    
    // Data Entered By User (Patient Data)
    var gender: Patient.Sex = Patient.Sex.male
    var age: Int?
    var height: Height?
    //var weight: String?
    var readingDiagnosis: String?
    var systolic: Int?
    var diastolic: Int?
    
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
    //@IBOutlet var weightLabel: UILabel!
    @IBOutlet var BPReadingLabel: UILabel!
    @IBOutlet var BPInterpretationText: UITextView!
    
    // Prepare data before view loads
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.genderLabel.text = (self.gender == Patient.Sex.male) ? "Male" : "Female";
        self.ageLabel.text = String(age!) + " yrs"
        // TODO: Create conditional statement for Imperial and Metric display and fix formatting
        self.heightLabel.text = String(format: "%.2f m", height!.meters)
        //self.weightLabel.text = weight
        self.BPReadingLabel.text = String(systolic!) + "/" + String(diastolic!) + " mmHg"
        self.BPInterpretationText.text = readingDiagnosis
    }
    
    // Creates a Patient Object to pass to the BPProGraphViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "showBPResultsGraph" {
                // Set the segue destination as the Navigation Controller and the BPProGraphView as the top view
                let navController = segue.destination as! UINavigationController
                let BPProGraphViewController = navController.topViewController as! BPProGraphViewController
                
                // Create a current Date object for reference
                let currentDate = Date()
                let calendar = Calendar.current
                var dateComponents = DateComponents()
                dateComponents.year = calendar.component(.year, from: currentDate) - age!
                // Create a Date object only from the (current year - age) component to find the DOB
                let dateOfBirth = calendar.date(from: dateComponents)
                BPProGraphViewController.patient = Patient(firstName: "First", lastName: "Last",
                                                           birthDate: dateOfBirth!,
                                                           height: self.height!,
                                                           sex: self.gender,
                                                           bloodPressureMeasurements: [BloodPressureMeasurement(systolic: self.systolic!, diastolic: self.diastolic!, measurementDate: currentDate)!])
            }
        }
    }
}

