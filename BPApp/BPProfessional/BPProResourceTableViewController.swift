//
//  BPProResourceViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPProResourceTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var articles: [Article] = []
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        articles.append(Article(title: "AAP Guidelines for Children",
                                description: "A clinical practice guideline for screening and management of high blood pressure in children and adolescents.",
                                url: "http://pediatrics.aappublications.org/content/pediatrics/early/2017/08/21/peds.2017-1904.full.pdf"))
        articles.append(Article(title: "NIH 4th Report Guidelines for Children",
                                description: "The recommendations concerning the diagnosis, evaluation, and treatment of hypertension in children.",
                                url: "https://www.nhlbi.nih.gov/files/docs/resources/heart/hbp_ped.pdf"))
        
        articles.append(Article(title: "JNC 8 Guidlines for Adults",
                                description: "vidence-Based JNC 8 Guideline for the Management of High Blood Pressure in Adults",
                                url: "https://sites.jamanetwork.com/jnc8/"))
        articles.append(Article(title: "Effects of JNC 8 Guidlines",
                                description: "vidence-Based JNC 8 Guideline for the Management of High Blood Pressure in Adults",
                                url: "https://jamanetwork.com/journals/jama/fullarticle/1853202"))
        // Add your articles here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let segments = ["Articles", "Tables"];
        
        segmentedControl = UISegmentedControl(items: segments);
        segmentedControl.selectedSegmentIndex = 0;
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(BPProResourceArticleCell.self, forCellReuseIdentifier: "BPProResourceArticle")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            // Articles selected
            numRows = articles.count
            break
        case 1:
            // Tables selected
            break
        default:
            break
        }
        return numRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPProResourceArticle", for: indexPath) as! BPProResourceArticleCell
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            // Articles selected
            cell.textLabel!.text = articles[indexPath.row].Title
            break
        case 1:
            // Tables selected
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            UIApplication.shared.open(URL(string: articles[indexPath.row].Url)!, options: [:], completionHandler: nil)
            break
        case 1:
            break
        default:
            break
        }
    }
    
    class BPProResourceArticleCell: UITableViewCell {
        
        // Creating this outlet from the storyboard immediately results in yellow triangle in the Table Cell references
        @IBOutlet var descriptionLabel: UILabel!
        
        
    }
}


