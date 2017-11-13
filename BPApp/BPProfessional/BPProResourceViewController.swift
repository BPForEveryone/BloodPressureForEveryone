//
//  BPProResourceViewController.swift
//  BPForProfessionals
//
//  Created by Chris Blackstone on 10/9/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPProResourceViewController: UIViewController {
    
    private var articles: [Article] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articles.append(Article(title: "The Fourth Report",
                                description: "The recommendations concerning the diagnosis, evaluation, and treatment of hypertension in children.",
                                url: "https://www.nhlbi.nih.gov/files/docs/resources/heart/hbp_ped.pdf"))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segments = ["Articles", "Tables"];
        
        let resourceTypeSegmentedControl = UISegmentedControl(items: segments);
        resourceTypeSegmentedControl.selectedSegmentIndex = 0;
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
