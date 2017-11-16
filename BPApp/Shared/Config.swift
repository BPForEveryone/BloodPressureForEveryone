//
//  Config.swift
//  BPApp
//
//  Created by MiningMarsh on 9/26/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import os.log

public class Config {
    
    // Where to save and load patient data.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let PatientStore = DocumentsDirectory.appendingPathComponent("patients")
    
    // Enum of possible number systems.
    public enum UnitSystem {
        case metric
        case imperial
    }
    
    // The currently active number system.
    public static var unitSystem: UnitSystem {
        get {
            if let format = UserDefaults.standard.object(forKey: "numSystem") as? Int {
                if format == 0 {
                    return UnitSystem.metric
                } else {
                    return UnitSystem.imperial
                }
            }
            
            return UnitSystem.metric
        }
        
        set(unitSystem) {
            if (unitSystem == UnitSystem.metric) {
                UserDefaults.standard.set(0, forKey: "numSystem");
            } else {
                UserDefaults.standard.set(1, forKey: "numSystem");
            }
            
            UserDefaults.standard.set(true, forKey: "numSystemChanged")
        }
    }
    
    // The list of patients we save.
    static public var patients: [Patient] {
        get {
            
            // Lock object so that we don't get while someone is setting.
            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            
            if let restored = NSKeyedUnarchiver.unarchiveObject(withFile: Config.PatientStore.path) as? [Patient] {
                
                return restored
            } else {
                os_log("Failed to restore patients.", log: OSLog.default, type: .debug)
                return []
            }
        }
        
        set(newPatients) {
            
            // Lock object so that we don't corrupt another lock operation.
            objc_sync_enter(self)
            defer { objc_sync_exit(self) }
            
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(
                newPatients,
                toFile: Config.PatientStore.path
            )
            
            if !isSuccessfulSave {
                os_log("Failed to persist patients.", log: OSLog.default, type: .error)
            }
        }
    }
    
    
}

