//
//  Article.swift
//  BPApp
//
//  Created by Andrew Hu on 11/12/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation

class Article {
    
    // Private fields for Article Title, a brief description, and the link to the article
    private var title: String
    //private var year: Int (possibly filter articles by year in future)
    private var description: String
    private var url: String
    
    // Properties
    public var Title: String {
        get {
            return self.title
        }
    }
    
    public var Description: String {
        get {
            return self.description
        }
    }
    
    public var Url: String {
        get {
            return self.url
        }
    }
    
    // Create a new Article
    init(title: String, description: String, url: String) {
        // Initialization won't fail if we are hard-coding the article entry
        self.title = title;
        self.description = description;
        self.url = url;
    }
}
