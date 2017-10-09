//
//  BPEPatientDetailPageViewController.swift
//  BPApp
//
//  Created by MiningMarsh on 10/8/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import UIKit

class BPEPatientDetailPageViewController: PageViewStaticListController {
    
    var patientId: Int = 0
    
    override func sourceStoryboard() -> String {
        return "BPEMain"
    }
    
    override func sourcePageIdentifiers() -> [String] {
        return ["PatientDetailPage1"]
    }
    
    /*override func newControllerSelected(controller: UIViewController) {
        if let patientDetailView = controller as? BPEPatientDetailViewController {
            patientDetailView.patientId = patientId
        }
    }*/
}
