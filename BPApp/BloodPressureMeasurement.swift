//
//  BloodPressureMeasurement.swift
//  BPApp
//
//  Created by MiningMarsh on 9/27/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import os.log

public class BloodPressureMeasurement: NSObject, NSCoding {
    
    var systolic: Int
    var diastolic: Int
    var measurementDate: Date
    
    // The properties to save for a patients, make sure this reflects with the properties patients have.
    struct PropertyKey {
        static let systolic = "systolic"
        static let diastolic = "diastolic"
        static let measurementDate = "measurementDate"
    }
    
    // Create a new blood pressure reading
    init?(systolic: Int, diastolic: Int, measurementDate: Date) {
    
        self.systolic = systolic
        self.diastolic = diastolic
        self.measurementDate = measurementDate
    }
    
    // Encoder used to store a patient.
    public func encode(with encoder: NSCoder) {
        encoder.encode(systolic, forKey: PropertyKey.systolic)
        encoder.encode(diastolic, forKey: PropertyKey.diastolic)
        encoder.encode(measurementDate, forKey: PropertyKey.measurementDate)
    }
    
    public required convenience init?(coder decoder: NSCoder) {
        
        let systolic = decoder.decodeInteger(forKey: PropertyKey.systolic)
        let diastolic = decoder.decodeInteger(forKey: PropertyKey.diastolic)
        
        // Date is required.
        guard let measurementDate = decoder.decodeObject(forKey: PropertyKey.measurementDate) as? Date else {
            os_log("Unable to decode the measurement date for a BloodPressureMeasurement object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Initialize with decoded values.
        self.init(
            systolic: systolic,
            diastolic: diastolic,
            measurementDate: measurementDate
        )
    }
}
