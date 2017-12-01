//
//  Resource.swift
//  BPApp
//
//  Created by Andrew Hu on 12/1/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation

class Resource {
    
    // These enumerations intend to provide new users an idea of what is being opened, as the actual URL is hidden from their knowledge
    // Denotes the medium of resource
    public enum ResourceMedium: String {
        case PDF, Pubmed, Site, Youtube
    }
    // Denotes the type of resource
    public enum ResourceType: String {
        case Article, AbstractOnly, AbstractWithFullText, FullText, Journal, Other, Report, Table, Video
    }
    
    // TODO: Implement a tag system for quick resource filtering, which can replace the above enums
    // Ex: Pubmed, NHLBI, PDF, Video, FullJournalText, etc.
    
    // Private fields for Resource medium and type
    private var resourceMedium: ResourceMedium
    private var resourceType: ResourceType
    // Private fields for title, a brief description, and the link to the article
    private var title: String
    //private var year: Int (possibly filter articles by year in future)
    private var description: String
    private var url: String
    
    // Properties
    public var ResourceMedium: String {
        get {
            return self.resourceMedium.rawValue
        }
    }
    
    public var ResourceType: String {
        get {
            return self.resourceType.rawValue
        }
    }
    
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
    
    // Create a new Resource
    init(medium: ResourceMedium, type: ResourceType, title: String, description: String, url: String) {
        // Initialization won't fail if we are hard-coding the article entry
        self.resourceMedium = medium
        self.resourceType = type
        self.title = title
        self.description = description
        self.url = url
    }
}

