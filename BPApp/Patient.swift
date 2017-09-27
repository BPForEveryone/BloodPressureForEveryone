//
//  Patient.swift
//  BPApp
//
//  Created by MiningMarsh on 9/26/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//
//  Implements a patient instance that supports serialization to be encoded and decoded.

import Foundation
import UIKit
import os.log

public class Patient: NSObject, NSCoding {
    
    //MARK: Properties
    
    var firstName: String
    var lastName: String
    var age: Int
    
    // The name to save the data under.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("patients")
    
    // The properties to save for a patients, make sure this reflects with the properties patients have.
    struct PropertyKey {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let age = "age"
    }
    
    // Create a new patient
    init?(firstName: String, lastName: String, age: Int) {
        
        // The names must not be empty
        guard !firstName.isEmpty else {
            return nil
        }
        
        guard !lastName.isEmpty else {
            return nil
        }
        
        // The age must be positive.
        guard age >= 0 else {
            return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    // Encoder used to store a patient.
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: PropertyKey.firstName)
        aCoder.encode(lastName, forKey: PropertyKey.lastName)
        aCoder.encode(age, forKey: PropertyKey.age)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        
        // First name is required
        guard let lastName = aDecoder.decodeObject(forKey: PropertyKey.firstName) as? String else {
            os_log("Unable to decode the first name for a Patient object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Last name is required.
        guard let firstName = aDecoder.decodeObject(forKey: PropertyKey.lastName) as? String else {
            os_log("Unable to decode the last name for a Patient object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Age is required.
        let age = aDecoder.decodeInteger(forKey: PropertyKey.age)

        // Initialize with decoded values.
        self.init(
            firstName: firstName,
            lastName: lastName,
            age: age
        )
    }
}
