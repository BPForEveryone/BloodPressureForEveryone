//
//  BPNormsEntry.swift
//  BPForProfessionals
//
//  Created by MiningMarsh on 11/5/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation

// An entry in the table, so we can easily encode the table.
public class BPNormsEntry {
    
    public var sex: Patient.Sex
    public var age: Int
    public var heightInMeters: Double
    public var systolic50: Int
    public var systolic90: Int
    public var systolic95: Int
    public var systolic95plus: Int
    public var diastolic50: Int
    public var diastolic90: Int
    public var diastolic95: Int
    public var diastolic95plus: Int
    
    init?(age: Int,
          sex: Patient.Sex,
          heightInMeters: Double,
          systolic50: Int,
          systolic90: Int,
          systolic95: Int,
          systolic95plus: Int,
          diastolic50: Int,
          diastolic90: Int,
          diastolic95: Int,
          diastolic95plus: Int) {
        
        self.sex = sex
        self.age = age
        self.heightInMeters = heightInMeters
        self.systolic50 = systolic50
        self.systolic90 = systolic90
        self.systolic95 = systolic95
        self.systolic95plus = systolic95plus
        self.diastolic50 = diastolic50
        self.diastolic90 = diastolic90
        self.diastolic95 = diastolic95
        self.diastolic95plus = diastolic95plus
    }
}
