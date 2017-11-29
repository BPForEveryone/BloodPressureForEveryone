//
//  BPESettingsViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPESettingsViewController : UITableViewController {
    
    // The number system selector.
    @IBOutlet weak var numSysSelection: UISegmentedControl!
    
    // Constructor.
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // When going back, dismiss.
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    // Called when the user changes the number system selected.
    @IBAction func numSysSelectionChanged(_ sender: Any) {
        
        // Change the saved unit system selection to store.
        Config.unitSystem = numSysSelection.selectedSegmentIndex == 0 ? Config.UnitSystem.metric : Config.UnitSystem.imperial
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // Setup the segment control to match the stored system.
        if Config.unitSystem == Config.UnitSystem.imperial {
            numSysSelection.selectedSegmentIndex = 1
        } else {
            numSysSelection.selectedSegmentIndex = 0
        }
    }
}
