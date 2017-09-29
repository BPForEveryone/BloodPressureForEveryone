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
        UserDefaults.standard.set(numSysSelection.selectedSegmentIndex, forKey: "numSystem")
        UserDefaults.standard.set(true, forKey: "numSystemChanged")
    }
    
    @IBAction func save2(_ sender: UIButton) {
        UserDefaults.standard.set(numSysSelection.selectedSegmentIndex, forKey: "numSystem")
        UserDefaults.standard.set(true, forKey: "numSystemChanged")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "numSystem") as? Int {
            numSysSelection.selectedSegmentIndex = x
            //print("Selection: ",numSysSelection.selectedSegmentIndex)
            //print("numSystem: ",UserDefaults.standard.object(forKey: "numSystem") ?? "blank")
        }
    }
}
