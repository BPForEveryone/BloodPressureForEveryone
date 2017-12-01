//
//  BPEResourceTableViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEResourceTableViewController: UITableViewController {
    
    public var resources: [Resource] = [
        Resource(
            medium: Resource.ResourceMedium.Youtube,
            type: Resource.ResourceType.Video,
            title: "How To Measure BP (Video)",
            description: "A video describing how to accurately measure blood pressure.",
            url: "https://www.youtube.com/watch?v=KI9HiLgcmm0"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.Site,
            type: Resource.ResourceType.Article,
            title: "How To Measure BP At Home",
            description: "The American Heart Association's guide to self-monitoring blood pressure at home.",
            url: "http://www.heart.org/HEARTORG/Conditions/HighBloodPressure/KnowYourNumbers/Monitoring-Your-Blood-Pressure-at-Home_UCM_301874_Article.jsp"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.PDF,
            type: Resource.ResourceType.Article,
            title: "What is High Blood Pressure",
            description: "Information describing what blood pressure is and what a high blood pressure means.",
            url: "http://www.heart.org/idc/groups/heart-public/@wcm/@hcm/documents/downloadable/ucm_300310.pdf"
        ),
        
        Resource(
            medium: Resource.ResourceMedium.PDF,
            type: Resource.ResourceType.Article,
            title: "How to Improve Blood Pressure",
            description: "What can I do to improve my blood pressure? A simple guide to improving blood pressure.",
            url: "http://www.heart.org/idc/groups/heart-public/@wcm/@hcm/documents/downloadable/ucm_486661.pdf"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPEResourceCell", for: indexPath)
        let titleLabel = cell.viewWithTag(20) as! UILabel
        titleLabel.text = resources[indexPath.row].Title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: resources[indexPath.row].Url)!, options: [:], completionHandler: nil)
    }
}
