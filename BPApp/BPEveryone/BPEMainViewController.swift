//
//  BPEMainViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEMainVewController: UIViewController {
    
    @IBOutlet weak var viewPatientsButton: UIButton!
    @IBOutlet weak var quickResourcesButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    let btnRadius: CGFloat = 20;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // This sets the system's default measurement system as the app's default
//        viewPatientsButton.layer.cornerRadius = btnRadius;
//        quickResourcesButton.layer.cornerRadius = btnRadius;
//        settingsButton.layer.cornerRadius = btnRadius;
//        
        
        
        if UserDefaults.standard.value(forKey: "numSystemChanged") as? Bool != true {
            UserDefaults.standard.set(false, forKey: "numSystemChanged")
            let isMetric = (Locale.current as NSLocale).object(forKey: NSLocale.Key.usesMetricSystem) as! Bool
            if isMetric {
                UserDefaults.standard.set(1, forKey: "numSystem")
            } else {
                UserDefaults.standard.set(0, forKey: "numSystem")
            }
        }
        //print("numSystemChanged: ",UserDefaults.standard.value(forKey: "numSystemChanged") ?? "numSystemChanged not set")
        //print("start numSystem: ",UserDefaults.standard.value(forKey: "numSystem") ?? "numSystem not set")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
