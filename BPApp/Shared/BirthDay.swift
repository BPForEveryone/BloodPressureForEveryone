//
//  BirthDay.swift
//  BPForProfessionals
//
//  Created by MiningMarsh on 9/30/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation

public class BirthDay {
    
    static public func format(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        return dateFormatter.string(from: date)
    }
}
