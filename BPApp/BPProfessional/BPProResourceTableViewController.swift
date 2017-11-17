//
//  BPProResourceViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPProResourceTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var articles: [Article] = [
        Article(title: "AAP Guidelines for Children",
                description: "A clinical practice guideline for screening and management of high blood pressure in children and adolescents.",
                url: "http://pediatrics.aappublications.org/content/pediatrics/early/2017/08/21/peds.2017-1904.full.pdf"
        ),
        Article(title: "NIH 4th Report Guidelines for Children",
                description: "The recommendations concerning the diagnosis, evaluation, and treatment of hypertension in children.",
                url: "https://www.nhlbi.nih.gov/files/docs/resources/heart/hbp_ped.pdf"
        ),
        Article(title: "JNC 8 Guidlines for Adults",
                description: "vidence-Based JNC 8 Guideline for the Management of High Blood Pressure in Adults",
                url: "https://sites.jamanetwork.com/jnc8/"
        ),
        Article(title: "Effects of JNC 8 Guidlines",
                description: "vidence-Based JNC 8 Guideline for the Management of High Blood Pressure in Adults",
                url: "https://jamanetwork.com/journals/jama/fullarticle/1853202"
        ),
    ]
    
    // Links to prototyped Segmented Control and Table View
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    // Segmented Control segments by name
    let segments = ["Articles", "Tables"];
    
    // Prepare the Segment Control and Table View before they appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Assign the segments to the Segmented Control and set its default to the first index
        segmentedControl = UISegmentedControl(items: segments);
        segmentedControl.selectedSegmentIndex = 0;
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Register the prototyped cell to the Table View
        tableView.register(BPProResourceArticleCell.self, forCellReuseIdentifier: "BPProResourceArticle")
        
        // Assign this UIViewController as the Data Source and Delegate to the Table View
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Perform any necessary actions after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Note: currently unattached reference. TODO: Create new link to a navigation bar button item.
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }

    // Called implicitly when the Table View is loaded, determines the number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0
        switch(segmentedControl.selectedSegmentIndex) {
        // Articles selected
        case 0:
            numRows = articles.count
            break
        // Tables selected
        case 1:
            break
        default:
            break
        }
        return numRows
    }
    
    // Called implicitly when the Table View is loaded, populates each cell with the Article object data
    // TODO: Used prototyped cell to also assign a brief description
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPProResourceArticle", for: indexPath) as! BPProResourceArticleCell
        switch(segmentedControl.selectedSegmentIndex) {
        // Articles selected
        case 0:
            // Displays the Article title in the cell
            cell.textLabel!.text = articles[indexPath.row].Title
            break
        // Tables selected
        case 1:
            break
        default:
            break
        }
        return cell
    }
    
    // Called when a Table View cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(segmentedControl.selectedSegmentIndex) {
        // Article Selected
        case 0:
            // Assign the proper URL based on the corresponding index of the cell and the Article array
            UIApplication.shared.open(URL(string: articles[indexPath.row].Url)!, options: [:], completionHandler: nil)
            break
        // Tables Selected
        case 1:
            // TODO: Redirect to a Table OR we use a completely different prototype for tables and repopulate the view completely
            break
        default:
            break
        }
    }
    
    // Prototype for UITableViewCell that shows a Title and Description with specified formatting
    class BPProResourceArticleCell: UITableViewCell {
        
        // Creating this outlet from the storyboard immediately results in yellow triangle in the Table Cell references, possible corrupted metadata
        // TODO: Needs a fix in the storyboard or metadata
        @IBOutlet var descriptionLabel: UILabel!
        
        
    }
}


