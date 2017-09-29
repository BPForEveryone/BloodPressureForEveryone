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
        let titleLabel = cell.viewWithTag(10) as! UILabel
        titleLabel.text = "\(Config.patients[indexPath.row].lastName), \(Config.patients[indexPath.row].firstName)"
        return cell
    }
    
}
