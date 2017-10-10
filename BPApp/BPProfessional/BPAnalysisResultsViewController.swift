//
//  BPAnalysisResultsViewController.swift
//  BPForProfessionals
//
//  Created by Andrew Hu on 9/28/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPAnalysisResultsViewController: UIViewController {
    var readingDiagnosis: String?
    var systolic: String?
    var diastolic: String?
    
    @IBOutlet weak var readingDiagnosisLabel: UILabel!
    @IBOutlet weak var systolicLabel: UILabel!
    @IBOutlet weak var diastolicLabel: UILabel!
    @IBOutlet weak var systolicPercentileLabel: UILabel!
    @IBOutlet weak var diastolicPercentileLabel: UILabel!
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)  
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readingDiagnosisLabel.text = readingDiagnosis
        self.systolicLabel.text = systolic
        self.diastolicLabel.text = diastolic
    }
}

