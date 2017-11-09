//
//  Patient.swift
//  BPApp
//
//  Created by MiningMarsh on 9/26/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//
//  Implements a patient instance that supports serialization to be encoded and decoded.

import Foundation
import os.log

public class Patient: NSObject, NSCoding {
    
    public enum Sex {
        case male
        case female
    }
    
    var firstName: String
    var lastName: String
    var birthDate: Date
    var height: Height
    private var sexInBoolean: Bool
    private var bloodPressureMeasurementsSorted: [BloodPressureMeasurement]! = []
    public var bloodPressureMeasurements: [BloodPressureMeasurement] {
        get {
            return self.bloodPressureMeasurementsSorted
        }
        
        set(newBloodPressureMeasurements) {
            self.bloodPressureMeasurementsSorted = newBloodPressureMeasurements.sorted {
                return $0.measurementDate < $1.measurementDate
            }
        }
    }
    
    public var norms: BPNormsEntry {
        get {
            return BPNormsTable.index(patient: self)
        }
    }
    
    public var sex: Patient.Sex {
        get {
            if self.sexInBoolean {
                return Patient.Sex.male
            } else {
                return Patient.Sex.female
            }
        }
        set(newSex) {
            switch newSex {
                case .male: self.sexInBoolean = true
                case .female: self.sexInBoolean = false
            }
        }
    }
    
    // The properties to save for a patients, make sure this reflects with the properties patients have.
    struct PropertyKey {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let birthDate = "birthDate"
        static let heightInMeters = "heightInMeters"
        static let sexInBoolean = "sexInBoolean"
        static let bloodPressureMeasurementsSorted = "bloodPressureMeasurementsSorted"
    }
    
    // Create a new patient
    init?(firstName: String, lastName: String, birthDate: Date, height: Height, sex: Patient.Sex, bloodPressureMeasurements: [BloodPressureMeasurement]) {
        
        // The names must not be empty
        guard !firstName.isEmpty else {
            return nil
        }
        
        guard !lastName.isEmpty else {
            return nil
        }
        
        // Height must be positive.
        guard height.meters >= 0.0 else {
            return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        self.height = height
        
        switch sex {
            case .male: self.sexInBoolean = true
            case .female: self.sexInBoolean = false
        }
        
        self.bloodPressureMeasurementsSorted = bloodPressureMeasurements.sorted {
            return $0.measurementDate < $1.measurementDate
        }
    }
    
    // Encoder used to store a patient.
    public func encode(with encoder: NSCoder) {
        encoder.encode(firstName, forKey: PropertyKey.firstName)
        encoder.encode(lastName, forKey: PropertyKey.lastName)
        encoder.encode(birthDate, forKey: PropertyKey.birthDate)
        encoder.encode(height.meters, forKey: PropertyKey.heightInMeters)
        encoder.encode(sexInBoolean, forKey: PropertyKey.sexInBoolean)
        encoder.encode(bloodPressureMeasurementsSorted, forKey: PropertyKey.bloodPressureMeasurementsSorted)
    }
    
    public required convenience init?(coder decoder: NSCoder) {
        
        // First name is required
        guard let lastName = decoder.decodeObject(forKey: PropertyKey.lastName) as? String else {
            os_log("Unable to decode the first name for a Patient object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Last name is required.
        guard let firstName = decoder.decodeObject(forKey: PropertyKey.firstName) as? String else {
            os_log("Unable to decode the last name for a Patient object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Age is required.
        guard let birthDate = decoder.decodeObject(forKey: PropertyKey.birthDate) as? Date else {
            os_log("Unable to decode the birth date for a Patient object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        let heightInMeters = decoder.decodeDouble(forKey: PropertyKey.heightInMeters)
        
        let sexInBoolean = decoder.decodeBool(forKey: PropertyKey.sexInBoolean)
        
        var sex: Patient.Sex = Patient.Sex.male
        if sexInBoolean {
            sex = Patient.Sex.male
        } else {
            sex = Patient.Sex.female
        }
        
        // Blood pressure log is required.
        guard let bloodPressureMeasurementsSorted = decoder.decodeObject(forKey: PropertyKey.bloodPressureMeasurementsSorted) as? [BloodPressureMeasurement] else {
            
            os_log("Unable to decode the blood pressure log for a Patient object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Initialize with decoded values.
        self.init(
            firstName: firstName,
            lastName: lastName,
            birthDate: birthDate,
            height: Height(heightInMeters: heightInMeters),
            sex: sex,
            bloodPressureMeasurements: bloodPressureMeasurementsSorted
        )
    }
}
