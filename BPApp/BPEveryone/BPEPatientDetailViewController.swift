//
//  BPEPatientDetailViewController.swift
//  BPForEveryone
//
//  Created by Chris Blackstone on 9/29/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit
import os.log

class BPEPatientDetailViewController: UITableViewController {
    
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var lastBPDateTimeLabel: UILabel!
    @IBOutlet weak var lastBPMeasurmentLabel: UILabel!
    @IBOutlet weak var lastBPPercentileLabel: UILabel!
    
    var patientId: Int = 0
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    public func update() {
        let patient = Config.patients[patientId]
        
        dateOfBirthLabel.text = BirthDay.format(date: patient.birthDate)
        heightLabel.text = patient.height.description
        
        if patient.bloodPressureMeasurements.count != 0 {
            
            let measurement = patient.bloodPressureMeasurements[0]
            lastBPDateTimeLabel.text = BirthDay.format(date: measurement.measurementDate)
            lastBPPercentileLabel.text = String(describing: patient.percentile)
            lastBPMeasurmentLabel.text = "\(patient.diastolic)/\(patient.systolic)"
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let patient = Config.patients[patientId]
        return "\(patient.firstName) \(patient.lastName)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        // Blood pressure list also requires a patient id.
        if (segue.identifier == "bloodPressureList") {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! BPEBPListViewController
            
            controller.patientId = self.patientId
        }
    }
}
