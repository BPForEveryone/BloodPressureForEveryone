//
//  BPESettingsViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPESettingsViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var numSysSelection: UISegmentedControl!
    
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        Config.unitSystem = numSysSelection.selectedSegmentIndex == 0 ? Config.UnitSystem.imperial : Config.UnitSystem.metric
    }
    
    @IBAction func save2(_ sender: UIButton) {
        Config.unitSystem = numSysSelection.selectedSegmentIndex == 0 ? Config.UnitSystem.imperial : Config.UnitSystem.metric
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Config.unitSystem == Config.UnitSystem.imperial {
            numSysSelection.selectedSegmentIndex = 0
        } else {
            numSysSelection.selectedSegmentIndex = 1
        }
    }
}
