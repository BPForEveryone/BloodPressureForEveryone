//
//  BPETrackUsersViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPETrackUsersViewControler: UITableViewController {
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.patients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Users", for: indexPath)
        let firstNameLabel = cell.viewWithTag(10) as! UILabel;
        let lastNameLabel = cell.viewWithTag(11) as! UILabel;
        let lastBPRecordingLabel = cell.viewWithTag(20) as! UILabel;
        firstNameLabel.text = Config.patients[indexPath.row].firstName;
        lastNameLabel.text = Config.patients[indexPath.row].lastName;
        lastBPRecordingLabel.text = "N/A";
        
        if(!Config.patients[indexPath.row].bloodPressureMeasurements.isEmpty) {
            let lastBPRecording = Config.patients[indexPath.row].bloodPressureMeasurements.last;
            lastBPRecordingLabel.text = "\(String(describing: lastBPRecording?.systolic))/\(String(describing: lastBPRecording?.diastolic))";
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        // This is the name of the segue in the storyboard.
        /*if (segue.identifier == "patientDetailView") {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! BPEPatientDetailPageViewController
            
            let cell = sender as! UITableViewCell
            let tableView = cell.superview as! UITableView
            let row = tableView.indexPathForSelectedRow!.row
            
            controller.patientId = row
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            Config.patients.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}
