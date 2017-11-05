//
//  BPETrackUsersViewTableController.swift
//  BPForProfessionals
//
//  Created by MiningMarsh on 9/29/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import UIKit

class BPETrackUsersViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.patients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Users", for: indexPath)
        let titleLabel = cell.viewWithTag(10) as! UILabel
        titleLabel.text = "\(Config.patients[indexPath.row].lastName), \(Config.patients[indexPath.row].firstName)"
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
}
