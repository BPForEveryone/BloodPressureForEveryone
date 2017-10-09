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
    
    var patientId: Int = 0
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let patient = Config.patients[patientId]

        firstNameLabel.text = patient.firstName
        lastNameLabel.text = patient.lastName
        dateOfBirthLabel.text = BirthDay.format(date: patient.birthDate)
        analysisGroupLabel.text = "N/A"
        heightLabel.text = patient.heightInMeters.description
        weightLabel.text = "N/A"
        lastBPDateTimeLabel.text = "N/A"
        lastBPPercentileLabel.text = "N/A"
        lastBPMeasurmentLabel.text = "N/A"
        lastBPReccomendationsLabel.text = "N/A"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        // This is the name of the segue in the storyboard.
        if (segue.identifier == "patientEditDetailView") {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! BPEPatientEditViewController
            
            controller.patientId = self.patientId
        }
        
        // Blood pressure list also requires a patient id.
        if (segue.identifier == "bloodPressureList") {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! BPEBPListViewController
            
            controller.patientId = self.patientId
        }
    }
}
