//
//  BPEResourceTableViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEResourceTableViewController: UITableViewController {
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPEResourceArticle", for: indexPath)
        let titleLabel = cell.viewWithTag(20) as! UILabel
        titleLabel.text = "How to Measure BP"
        return cell
    }
}
