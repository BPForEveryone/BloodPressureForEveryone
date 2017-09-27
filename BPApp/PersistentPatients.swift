//
//  PersistentPatients.swift
//  BPApp
//
//  Created by MiningMarsh on 9/26/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import UIKit
import os.log

public class PersistentPatients {
    
    // Where to save and load patient data.
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let PersistentStore = DocumentsDirectory.appendingPathComponent("patients")
    
    // The list of patients we save.
    static var patients: [Patient]?
    static var lock = false
    
    // Get a list of patients.
    public func patientList() -> [Patient] {
        objc_sync_enter(PersistentPatients.lock)
        defer { objc_sync_exit(PersistentPatients.lock) }
        
        if PersistentPatients.patients == nil {
            PersistentPatients.patients = []
        }
        
        return PersistentPatients.patients!
    }
    
    // Initializer
    init?() {
        objc_sync_enter(PersistentPatients.lock)
        defer { objc_sync_exit(PersistentPatients.lock) }

        // If we haven't yet grabbed patients, do it now.
        if PersistentPatients.patients == nil {
            restore()
        }
    }
    
    // Persist whenever the object is destroyed.
    deinit {
        persist();
    }
    
    // Persist the patients.
    private func persist() {
        objc_sync_enter(PersistentPatients.lock)
        defer { objc_sync_exit(PersistentPatients.lock) }
        
        if let patients = PersistentPatients.patients {
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(patients, toFile: PersistentPatients.PersistentStore.path)
            if isSuccessfulSave {
                os_log("Patients persisted.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to persist patients...", log: OSLog.default, type: .error)
            }
        }
        
    }
    
    // Restore the patients from persistent store.
    private func restore() {
        objc_sync_enter(PersistentPatients.lock)
        defer { objc_sync_exit(PersistentPatients.lock) }
        
        if let restored = NSKeyedUnarchiver.unarchiveObject(withFile: PersistentPatients.PersistentStore.path) as? [Patient] {
            PersistentPatients.patients = restored
            os_log("Patients restored.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to restore patients.", log: OSLog.default, type: .debug)
            PersistentPatients.patients = []
        }
    }

}
