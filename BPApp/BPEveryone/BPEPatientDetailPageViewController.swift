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
        return "BPEBloodPressure"
    }
    
    override func sourcePageIdentifiers() -> [String] {
        return ["PatientDetailPage1", "PatientDetailPage2"]
    }
    
    override func initController(controller: UIViewController) {
        if let patientDetailView = controller as? BPEPatientDetailViewController {
            patientDetailView.patientId = patientId
        }
        
        if let patientGraphView = controller as? BPEPatientGraphViewController {
            patientGraphView.patientId = patientId
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        // This is the name of the segue in the storyboard.
        if (segue.identifier == "patientEditView") {
            
            let controller = (segue.destination as! UINavigationController).topViewController as! BPEPatientEditViewController
            
            controller.patientId = patientId
        }
    }
}
