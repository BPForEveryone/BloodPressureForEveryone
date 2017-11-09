//
//  File.swift
//  BPForProfessionals
//
//  Created by MiningMarsh on 11/9/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation

public class Height {
    
    public var meters = 0.0
    
    public var feet: Double {
        get {
            return self.meters * 3.28084
        }
        
        set(feet) {
            self.meters = feet / 3.28084
        }
    }
    
    public init(heightInMeters: Double) {
        self.meters = heightInMeters
    }
    
    public init(heightInFeet: Double) {
        self.feet = heightInFeet
    }
    
    public var description: String {
        get {
            if Config.unitSystem == Config.UnitSystem.metric {
                return "\(self.meters) m"
            } else {
                return "\(self.meters * 3.28084) ft"
            }
        }
    }
}
