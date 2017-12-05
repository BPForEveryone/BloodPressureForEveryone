//
//  File.swift
//  BPForProfessionals
//
//  Created by MiningMarsh on 11/9/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation

// Represents a height and auto converts between feet and meters.
public class Height {
    
    // Actual storage of height.
    public var meters = 0.0
    
    // Convert the internal meters to feet.
    public var feet: Double {
        get {
            return self.meters * 3.28084
        }
        
        set(feet) {
            self.meters = feet / 3.28084
        }
    }
    
    // Create a height object using meters.
    public init(heightInMeters: Double) {
        self.meters = heightInMeters
    }
    
    // Create a height object using feet.
    public init(heightInFeet: Double) {
        self.feet = heightInFeet
    }
    
    // Display the height in either meters or feet/in depending on the mode of the config.
    public var description: String {
        get {
            
            // Display in metric.
            if Config.unitSystem == Config.UnitSystem.metric {
                return String(format: "%.2f m", self.meters)
            
            // Displayt in ft, in
            } else {
                
                // Get the feet and inches part.
                let conv = self.feet
                let ft = floor(conv)
                let inch = floor(conv.truncatingRemainder(dividingBy: 1.0) * 12)
                
                return "\(Int(ft)) ft \(Int(inch)) in"
            }
        }
    }
}
