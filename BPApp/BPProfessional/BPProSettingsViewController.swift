//
//  BPProSettingsViewController.swift
//  BPForProfessionals
//
//  Created by Jacob Light on 9/23/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

//import Foundation
import UIKit

import UIKit

class BPProSettingsViewController : UIViewController {
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
    
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "numSystem") as? Int {
            numSysSelection.selectedSegmentIndex = x
            //print("Selection: ",numSysSelection.selectedSegmentIndex)
            //print("numSystem: ",UserDefaults.standard.object(forKey: "numSystem") ?? "blank")
        }
    }
}
