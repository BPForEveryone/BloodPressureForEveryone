//
//  BPEBPListViewController.swift
//  BPApp
//
//  Created by MiningMarsh on 10/8/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import UIKit
import os.log

class BPEBPListViewController: UITableViewController {
    
    public var patientId: Int = 0
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.patients[self.patientId].bloodPressureMeasurements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BloodPressure", for: indexPath)
        
        let measurement = Config.patients[self.patientId].bloodPressureMeasurements[indexPath.row];
        
        let dateLabel = cell.viewWithTag(10) as! UILabel;
        let bpLabel = cell.viewWithTag(11) as! UILabel;
        
        dateLabel.text = BirthDay.format(date: measurement.measurementDate);
        
        bpLabel.text = "\(measurement.systolic)/\(measurement.diastolic)"

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        // Pass patient into dialog for creating a new blood pressure measurement
        if (segue.identifier == "recordBP") {
            let controller = (segue.destination as! UINavigationController).topViewController as! BPERecordBPViewController
            
            controller.patientId = self.patientId
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
}
