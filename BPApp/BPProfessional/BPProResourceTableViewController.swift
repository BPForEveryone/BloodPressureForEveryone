//
//  BPProResourceViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPProResourceTableViewController: UITableViewController {
    
    public var resources: [Resource] = [
        Resource(
            medium: Resource.ResourceMedium.PDF,
            type: Resource.ResourceType.FullText,
            title: "AAP Guidelines for Children",
            description: "A clinical practice guideline for screening and management of high blood pressure in children and adolescents",
            url: "http://pediatrics.aappublications.org/content/pediatrics/early/2017/08/21/peds.2017-1904.full.pdf"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.PDF,
            type: Resource.ResourceType.FullText,
            title: "NIH 4th Report Guidelines for Children",
            description: "The recommendations concerning the diagnosis, evaluation, and treatment of hypertension in children",
            url: "https://www.nhlbi.nih.gov/files/docs/resources/heart/hbp_ped.pdf"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.FullText,
            title: "2014 Evidence-Based Guideline for the Management of High Blood Pressure in Adults",
            description: "Report from the panel members appointed to the Eighth Joint National Committee (JNC 8)",
            url: "https://jamanetwork.com/journals/jama/fullarticle/1853202"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Pubmed,
            type: Resource.ResourceType.AbstractWithFullText,
            title: "DASH is Associated with Reduced Incidence Metabolic Syndrome in Children and Adolescents",
            description: "An assessment the association of adherence to Dietary Approaches to Stop Hypertension (DASH)-style diet with development of metabolic syndrome (MetS) in children and adolescents",
            url: "https://www.ncbi.nlm.nih.gov/pubmed/27156186"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.Other,
            title: "The DASH Diet Eating Plan",
            description: "DASH Diet Organization Homepage",
            url: "http://dashdiet.org/default.asp"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.PDF,
            type: Resource.ResourceType.Article,
            title: "In Brief: Your Guide to Lowering Your Blood Pressure With DASH",
            description: "NHLBI guide to a brief DASH eating plan, from caloric intake to food groups to additional lifestyle tips",
            url: "https://www.nhlbi.nih.gov/files/docs/public/heart/dash_brief.pdf"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.Other,
            title: "MedlinePlus.gov - DASH Diet",
            description: "MedlinePlus.gov health topic on the DASH Diet - contains links to other resources, journal articles, and clinial trials ",
            url: "https://medlineplus.gov/dashdiet.html"
        ),
    
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.Other,
            title: "NHLBI Heart and Vascular Resources",
            description: "Additional resources (links to websites, PDFs of factsheets, etc.) regarding various heart and vascular conditions",
            url: "https://www.nhlbi.nih.gov/health-pro/resources/heart"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.Other,
            title: "healthychildren.org from the AAP",
            description: "Healthy Children organization homepage",
            url: "https://www.healthychildren.org/English/Pages/default.aspx"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.Other,
            title: "MyFitnessPal",
            description: "Homepage for MyFitnessPal, a calorie counting app for web and mobile",
            url: "https://www.myfitnesspal.com/"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.Article,
            title: "How to Track Your Sodium",
            description: "Sodium tracker and information provided by the AHA",
            url: "http://www.heart.org/HEARTORG/HealthyLiving/HealthyEating/Nutrition/How-to-Track-Your-Sodium_UCM_449547_Article.jsp"
        )
    ]
    
    // Prepare the Segment Control and Table View before they appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.rowHeight = 160.0
    }
    
    // Perform any necessary actions after the view has been loaded
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Called implicitly when the Table View is loaded, determines the number of rows for each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    // Called implicitly when the Table View is loaded, populates each cell with the Article object data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPProResourceCell", for: indexPath)
        // Obtain
        let titleLabel = cell.viewWithTag(5) as! UILabel
        let descriptionLabel = cell.viewWithTag(7) as! UILabel
        let metaLabel = cell.viewWithTag(9) as! UILabel
        
        metaLabel.text = "[" + resources[indexPath.row].ResourceMedium + "]" + "[" + resources[indexPath.row].ResourceType + "]"
        metaLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text = resources[indexPath.row].Title
        descriptionLabel.text = resources[indexPath.row].Description
        return cell
    }
    
    // Called when a Table View cell is selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: resources[indexPath.row].Url)!, options: [:], completionHandler: nil)
    }
}


