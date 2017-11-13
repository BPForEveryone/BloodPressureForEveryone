//
//  BPEResourceTableViewController.swift
//  BPApp
//
//  Created by Chris Blackstone on 4/24/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import UIKit

class BPEResourceTableViewController: UITableViewController {
//    @IBAction func back() {
//        dismiss(animated: true, completion: nil)
//    }
    
    public var articles: [Article] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        articles.append(Article(title: "How To Measure BP (Video)",
                                description: "A video describing how to accurately measure blood pressure.",
                                url: "https://www.youtube.com/watch?v=KI9HiLgcmm0"))
        articles.append(Article(title: "How To Measure BP At Home",
                                description: "The American Heart Association's guide to slef-monitoring blood pressure at home.",
                                url: "http://www.heart.org/HEARTORG/Conditions/HighBloodPressure/KnowYourNumbers/Monitoring-Your-Blood-Pressure-at-Home_UCM_301874_Article.jsp"))
        
        articles.append(Article(title: "What is High Blood Pressure",
                                description: "Information describing what blood pressure is and what a high blood pressure means.",
                                url: "http://www.heart.org/idc/groups/heart-public/@wcm/@hcm/documents/downloadable/ucm_300310.pdf"))
        articles.append(Article(title: "How to Improve Blood Pressure",
                                description: "What can I do to improve my blood pressure? A simple guide to improving blood pressure.",
                                url: "http://www.heart.org/idc/groups/heart-public/@wcm/@hcm/documents/downloadable/ucm_486661.pdf"))
        // Add your articles here
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BPEResourceArticle", for: indexPath)
        let titleLabel = cell.viewWithTag(20) as! UILabel
        titleLabel.text = articles[indexPath.row].Title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: articles[indexPath.row].Url)!, options: [:], completionHandler: nil)
    }
}
