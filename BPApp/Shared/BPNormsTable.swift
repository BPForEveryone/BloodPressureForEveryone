//
//  BPNormsTable.swift
//  BPApp
//
//  Created by MiningMarsh on 10/31/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation

class BPNormsTable {
    
    private class NormsTable {
        
        // Binary tree implementing range checks.
        // First you add all nodes, then you call balance()
        private class HeightRangeTree {
            
            // The tree gets flattened into a list.
            private var rangeTree: [BPNormsEntry] = []
            
            public var RangeTree: [BPNormsEntry] {
                get {
                    balance()
                    return self.rangeTree
                }
            }
            
            // Whether the tree is currently balanced.
            private var balanced: Bool = true
            
            // Add a range.
            public func append(newElement: BPNormsEntry) {
                rangeTree.append(newElement)
                
                balanced = false
            }
            
            // Balance the tree.
            private func balance() {
                
                // Sort the list so we can balance around the center node.
                rangeTree = rangeTree.sorted {
                    return $0.heightInMeters < $1.heightInMeters
                }
                
                // Tree is now "balanced" in that we can do a binary search on it now.
                
            }
            
            // Index by value.
            public subscript(heightInMeters: Double) -> BPNormsEntry {
            
                get {
                    
                    // Make sure tree is balanced.
                    if (!balanced) {
                        balance()
                    }
                    
                    // Upper limit of binary search.
                    var upper: Int = rangeTree.count
                    
                    // Lower limit of binary search.
                    var lower: Int = 0
                    
                    // If the height is lower than first entry, use first entry.
                    if (heightInMeters <= rangeTree[0].heightInMeters) {
                        return self.rangeTree[0]
                    }
                    
                    // If the age is higher than last entry, use last entry.
                    if (heightInMeters >= rangeTree[rangeTree.count - 1].heightInMeters) {
                        return self.rangeTree[rangeTree.count - 1]
                    }
                    
                    // Find node.
                    while (true) {
                        
                        // The target index to check.
                        let index: Int = (upper + lower) / 2
                        
                        // Check the height is in the target range.
                        if (heightInMeters >= rangeTree[index].heightInMeters
                            && (index != rangeTree.count
                                && heightInMeters < rangeTree[index + 1].heightInMeters)) {
                                    
                            return self.rangeTree[index]
                        }
                        
                        // Recurse.
                        if (heightInMeters < rangeTree[index].heightInMeters) {
                            upper = index
                        } else {
                            lower = index
                        }
                    }
                }
            }
        }
        
        // Indexed by age, then sex, then contains a height object.
        private var table: [[HeightRangeTree?]] = []
        
        // Get age from date.
        private func age(from: Date) -> Int {
            return NSCalendar.current.dateComponents(
                Set<Calendar.Component>([.second, .minute, .hour, .day, .month, .year]),
                from: from, to: Date()
            ).year!
        }
        
        init?(norms: BPNormsEntry...) {
            
            // Push all norms to tree.
            for norm in norms {
                
                let normAge = norm.age - 1
                
                // Make sure the table has room for this entry.
                while table.count <= normAge {
                    table.append([nil, nil])
                }
                
                // Convert sex to index.
                let sexIndex = norm.sex == Patient.Sex.male ? 0 : 1
                
                // Make sure the range tree exists.
                if table[normAge][sexIndex] == nil {
                    table[normAge][sexIndex] = HeightRangeTree()
                }
                
                // Add entry.
                table[normAge][sexIndex]!.append(newElement: norm)
            }
        }
        
        // Index the table.
        public func index(patient: Patient) -> BPNormsEntry {
            
            // Convert sex to index.
            let sexIndex = patient.sex == Patient.Sex.male ? 0 : 1
            
            let page = age(from: patient.birthDate) - 1;
            
            // Edge cases.
            if (page <= 1) {
                return table[0][sexIndex]![patient.height.meters];
            }
            
            // Edge cases.
            if (page >= table.count - 1) {
                return table[table.count - 1][sexIndex]![patient.height.meters];
            }
            
            return table[page][sexIndex]![patient.height.meters]
        }
        
        // Index the table using only Sex and Age
        public func indexForArray(patient: Patient) -> [BPNormsEntry] {
            
            // Convert sex to index.
            let sexIndex = patient.sex == Patient.Sex.male ? 0 : 1
            
            let page = age(from: patient.birthDate) - 1;
            
            // Edge cases.
            if (page <= 1) {
                return table[0][sexIndex]!.RangeTree
            }
            
            // Edge cases.
            if (page >= table.count - 1) {
                return table[table.count - 1][sexIndex]!.RangeTree
            }
            
            return table[page][sexIndex]!.RangeTree
        }
    }
    
    public static func index(patient: Patient) -> BPNormsEntry {
        return self.normsTable.index(patient: patient);
    }
    
    public static func indexForArray(patient: Patient) -> [BPNormsEntry] {
        return self.normsTable.indexForArray(patient: patient);
    }
    // The following table is autogenerated by a script, do not touch!
    static private var normsTable: NormsTable = NormsTable(norms:
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.male,
			heightInMeters: 0.77200000000000002,
			systolic50: 85,
			systolic90: 98,
			systolic95: 102,
			systolic95plus: 114,
			diastolic50: 40,
			diastolic90: 52,
			diastolic95: 54,
			diastolic95plus: 66
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.male,
			heightInMeters: 0.78299999999999992,
			systolic50: 85,
			systolic90: 99,
			systolic95: 102,
			systolic95plus: 114,
			diastolic50: 40,
			diastolic90: 52,
			diastolic95: 54,
			diastolic95plus: 66
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.male,
			heightInMeters: 0.80200000000000005,
			systolic50: 86,
			systolic90: 99,
			systolic95: 103,
			systolic95plus: 115,
			diastolic50: 40,
			diastolic90: 53,
			diastolic95: 55,
			diastolic95plus: 67
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.male,
			heightInMeters: 0.82400000000000007,
			systolic50: 86,
			systolic90: 100,
			systolic95: 103,
			systolic95plus: 115,
			diastolic50: 41,
			diastolic90: 53,
			diastolic95: 55,
			diastolic95plus: 67
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.male,
			heightInMeters: 0.84599999999999997,
			systolic50: 87,
			systolic90: 100,
			systolic95: 104,
			systolic95plus: 116,
			diastolic50: 41,
			diastolic90: 54,
			diastolic95: 56,
			diastolic95plus: 68
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.male,
			heightInMeters: 0.86699999999999999,
			systolic50: 88,
			systolic90: 101,
			systolic95: 105,
			systolic95plus: 117,
			diastolic50: 42,
			diastolic90: 54,
			diastolic95: 57,
			diastolic95plus: 69
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.male,
			heightInMeters: 0.879,
			systolic50: 88,
			systolic90: 101,
			systolic95: 105,
			systolic95plus: 117,
			diastolic50: 42,
			diastolic90: 54,
			diastolic95: 57,
			diastolic95plus: 69
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.male,
			heightInMeters: 0.86099999999999999,
			systolic50: 87,
			systolic90: 100,
			systolic95: 104,
			systolic95plus: 116,
			diastolic50: 43,
			diastolic90: 55,
			diastolic95: 57,
			diastolic95plus: 69
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.male,
			heightInMeters: 0.87400000000000011,
			systolic50: 87,
			systolic90: 100,
			systolic95: 105,
			systolic95plus: 117,
			diastolic50: 43,
			diastolic90: 55,
			diastolic95: 58,
			diastolic95plus: 70
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.male,
			heightInMeters: 0.89599999999999991,
			systolic50: 88,
			systolic90: 101,
			systolic95: 105,
			systolic95plus: 117,
			diastolic50: 44,
			diastolic90: 56,
			diastolic95: 58,
			diastolic95plus: 70
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.male,
			heightInMeters: 0.92099999999999993,
			systolic50: 89,
			systolic90: 102,
			systolic95: 106,
			systolic95plus: 118,
			diastolic50: 44,
			diastolic90: 56,
			diastolic95: 59,
			diastolic95plus: 71
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.male,
			heightInMeters: 0.94700000000000006,
			systolic50: 89,
			systolic90: 103,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 45,
			diastolic90: 57,
			diastolic95: 60,
			diastolic95plus: 72
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.male,
			heightInMeters: 0.97099999999999997,
			systolic50: 90,
			systolic90: 103,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 46,
			diastolic90: 58,
			diastolic95: 61,
			diastolic95plus: 73
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.male,
			heightInMeters: 0.98499999999999999,
			systolic50: 91,
			systolic90: 104,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 46,
			diastolic90: 58,
			diastolic95: 61,
			diastolic95plus: 73
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.male,
			heightInMeters: 0.92500000000000004,
			systolic50: 88,
			systolic90: 101,
			systolic95: 106,
			systolic95plus: 118,
			diastolic50: 45,
			diastolic90: 58,
			diastolic95: 60,
			diastolic95plus: 72
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.male,
			heightInMeters: 0.93900000000000006,
			systolic50: 89,
			systolic90: 102,
			systolic95: 106,
			systolic95plus: 118,
			diastolic50: 46,
			diastolic90: 58,
			diastolic95: 61,
			diastolic95plus: 73
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.male,
			heightInMeters: 0.96299999999999997,
			systolic50: 89,
			systolic90: 102,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 46,
			diastolic90: 59,
			diastolic95: 61,
			diastolic95plus: 73
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.male,
			heightInMeters: 0.98999999999999999,
			systolic50: 90,
			systolic90: 103,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 47,
			diastolic90: 59,
			diastolic95: 62,
			diastolic95plus: 74
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.male,
			heightInMeters: 1.018,
			systolic50: 91,
			systolic90: 104,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 48,
			diastolic90: 60,
			diastolic95: 63,
			diastolic95plus: 75
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.male,
			heightInMeters: 1.0429999999999999,
			systolic50: 92,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 49,
			diastolic90: 61,
			diastolic95: 64,
			diastolic95plus: 76
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.male,
			heightInMeters: 1.0580000000000001,
			systolic50: 92,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 49,
			diastolic90: 61,
			diastolic95: 64,
			diastolic95plus: 76
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.male,
			heightInMeters: 0.98499999999999999,
			systolic50: 90,
			systolic90: 102,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 48,
			diastolic90: 60,
			diastolic95: 63,
			diastolic95plus: 75
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.male,
			heightInMeters: 1.002,
			systolic50: 90,
			systolic90: 103,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 49,
			diastolic90: 61,
			diastolic95: 64,
			diastolic95plus: 76
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.male,
			heightInMeters: 1.0290000000000001,
			systolic50: 91,
			systolic90: 104,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 49,
			diastolic90: 62,
			diastolic95: 65,
			diastolic95plus: 77
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.male,
			heightInMeters: 1.0590000000000002,
			systolic50: 92,
			systolic90: 105,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 50,
			diastolic90: 62,
			diastolic95: 66,
			diastolic95plus: 78
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.male,
			heightInMeters: 1.089,
			systolic50: 93,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 51,
			diastolic90: 63,
			diastolic95: 67,
			diastolic95plus: 79
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.male,
			heightInMeters: 1.115,
			systolic50: 94,
			systolic90: 106,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 52,
			diastolic90: 64,
			diastolic95: 67,
			diastolic95plus: 79
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.male,
			heightInMeters: 1.1320000000000001,
			systolic50: 94,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 52,
			diastolic90: 64,
			diastolic95: 68,
			diastolic95plus: 80
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.male,
			heightInMeters: 1.044,
			systolic50: 91,
			systolic90: 103,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 51,
			diastolic90: 63,
			diastolic95: 66,
			diastolic95plus: 78
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.male,
			heightInMeters: 1.0620000000000001,
			systolic50: 92,
			systolic90: 104,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 51,
			diastolic90: 64,
			diastolic95: 67,
			diastolic95plus: 79
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.male,
			heightInMeters: 1.091,
			systolic50: 93,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 52,
			diastolic90: 65,
			diastolic95: 68,
			diastolic95plus: 80
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.male,
			heightInMeters: 1.1240000000000001,
			systolic50: 94,
			systolic90: 106,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 53,
			diastolic90: 65,
			diastolic95: 69,
			diastolic95plus: 81
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.male,
			heightInMeters: 1.157,
			systolic50: 95,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 54,
			diastolic90: 66,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.male,
			heightInMeters: 1.1859999999999999,
			systolic50: 96,
			systolic90: 108,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 55,
			diastolic90: 67,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.male,
			heightInMeters: 1.2030000000000001,
			systolic50: 96,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 55,
			diastolic90: 67,
			diastolic95: 71,
			diastolic95plus: 83
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.male,
			heightInMeters: 1.103,
			systolic50: 93,
			systolic90: 105,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 54,
			diastolic90: 66,
			diastolic95: 69,
			diastolic95plus: 81
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.male,
			heightInMeters: 1.1220000000000001,
			systolic50: 93,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 54,
			diastolic90: 66,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.male,
			heightInMeters: 1.153,
			systolic50: 94,
			systolic90: 106,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 55,
			diastolic90: 67,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.male,
			heightInMeters: 1.1890000000000001,
			systolic50: 95,
			systolic90: 107,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 56,
			diastolic90: 68,
			diastolic95: 71,
			diastolic95plus: 83
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.male,
			heightInMeters: 1.224,
			systolic50: 96,
			systolic90: 109,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 68,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.male,
			heightInMeters: 1.256,
			systolic50: 97,
			systolic90: 110,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 57,
			diastolic90: 69,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.male,
			heightInMeters: 1.2749999999999999,
			systolic50: 98,
			systolic90: 110,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 58,
			diastolic90: 69,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.male,
			heightInMeters: 1.161,
			systolic50: 94,
			systolic90: 106,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 56,
			diastolic90: 68,
			diastolic95: 71,
			diastolic95plus: 83
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.male,
			heightInMeters: 1.1799999999999999,
			systolic50: 94,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 56,
			diastolic90: 68,
			diastolic95: 71,
			diastolic95plus: 83
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.male,
			heightInMeters: 1.214,
			systolic50: 95,
			systolic90: 108,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 57,
			diastolic90: 69,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.male,
			heightInMeters: 1.2509999999999999,
			systolic50: 97,
			systolic90: 109,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 58,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.male,
			heightInMeters: 1.2890000000000001,
			systolic50: 98,
			systolic90: 110,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 58,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.male,
			heightInMeters: 1.3240000000000001,
			systolic50: 98,
			systolic90: 111,
			systolic95: 115,
			systolic95plus: 127,
			diastolic50: 59,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.male,
			heightInMeters: 1.345,
			systolic50: 99,
			systolic90: 111,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 59,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.male,
			heightInMeters: 1.214,
			systolic50: 95,
			systolic90: 107,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 57,
			diastolic90: 69,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.male,
			heightInMeters: 1.2350000000000001,
			systolic50: 96,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.male,
			heightInMeters: 1.27,
			systolic50: 97,
			systolic90: 109,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 58,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.male,
			heightInMeters: 1.3100000000000001,
			systolic50: 98,
			systolic90: 110,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 59,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.male,
			heightInMeters: 1.351,
			systolic50: 99,
			systolic90: 111,
			systolic95: 115,
			systolic95plus: 127,
			diastolic50: 59,
			diastolic90: 72,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.male,
			heightInMeters: 1.3880000000000001,
			systolic50: 99,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 60,
			diastolic90: 72,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.male,
			heightInMeters: 1.4099999999999999,
			systolic50: 100,
			systolic90: 112,
			systolic95: 117,
			systolic95plus: 129,
			diastolic50: 60,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.male,
			heightInMeters: 1.26,
			systolic50: 96,
			systolic90: 107,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 70,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.male,
			heightInMeters: 1.2830000000000001,
			systolic50: 97,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 58,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.male,
			heightInMeters: 1.321,
			systolic50: 98,
			systolic90: 109,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 59,
			diastolic90: 72,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.male,
			heightInMeters: 1.3630000000000002,
			systolic50: 99,
			systolic90: 110,
			systolic95: 115,
			systolic95plus: 127,
			diastolic50: 60,
			diastolic90: 73,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.male,
			heightInMeters: 1.4069999999999998,
			systolic50: 100,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 61,
			diastolic90: 74,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.male,
			heightInMeters: 1.4469999999999998,
			systolic50: 101,
			systolic90: 113,
			systolic95: 118,
			systolic95plus: 130,
			diastolic50: 62,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.male,
			heightInMeters: 1.4709999999999999,
			systolic50: 101,
			systolic90: 114,
			systolic95: 119,
			systolic95plus: 131,
			diastolic50: 62,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 10,
			sex: Patient.Sex.male,
			heightInMeters: 1.3019999999999998,
			systolic50: 97,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 59,
			diastolic90: 72,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 10,
			sex: Patient.Sex.male,
			heightInMeters: 1.327,
			systolic50: 98,
			systolic90: 109,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 60,
			diastolic90: 73,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 10,
			sex: Patient.Sex.male,
			heightInMeters: 1.367,
			systolic50: 99,
			systolic90: 111,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 61,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 10,
			sex: Patient.Sex.male,
			heightInMeters: 1.413,
			systolic50: 100,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 62,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 10,
			sex: Patient.Sex.male,
			heightInMeters: 1.4590000000000001,
			systolic50: 101,
			systolic90: 113,
			systolic95: 118,
			systolic95plus: 130,
			diastolic50: 63,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 10,
			sex: Patient.Sex.male,
			heightInMeters: 1.5009999999999999,
			systolic50: 102,
			systolic90: 115,
			systolic95: 120,
			systolic95plus: 132,
			diastolic50: 63,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 10,
			sex: Patient.Sex.male,
			heightInMeters: 1.5269999999999999,
			systolic50: 103,
			systolic90: 116,
			systolic95: 121,
			systolic95plus: 133,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 11,
			sex: Patient.Sex.male,
			heightInMeters: 1.347,
			systolic50: 99,
			systolic90: 110,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 61,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 11,
			sex: Patient.Sex.male,
			heightInMeters: 1.3730000000000002,
			systolic50: 99,
			systolic90: 111,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 61,
			diastolic90: 74,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 11,
			sex: Patient.Sex.male,
			heightInMeters: 1.415,
			systolic50: 101,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 11,
			sex: Patient.Sex.male,
			heightInMeters: 1.464,
			systolic50: 102,
			systolic90: 114,
			systolic95: 118,
			systolic95plus: 130,
			diastolic50: 63,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 11,
			sex: Patient.Sex.male,
			heightInMeters: 1.5130000000000001,
			systolic50: 103,
			systolic90: 116,
			systolic95: 120,
			systolic95plus: 132,
			diastolic50: 63,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 11,
			sex: Patient.Sex.male,
			heightInMeters: 1.5580000000000001,
			systolic50: 104,
			systolic90: 117,
			systolic95: 123,
			systolic95plus: 135,
			diastolic50: 63,
			diastolic90: 76,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 11,
			sex: Patient.Sex.male,
			heightInMeters: 1.5859999999999999,
			systolic50: 106,
			systolic90: 118,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 63,
			diastolic90: 76,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 12,
			sex: Patient.Sex.male,
			heightInMeters: 1.403,
			systolic50: 101,
			systolic90: 113,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 61,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 12,
			sex: Patient.Sex.male,
			heightInMeters: 1.4299999999999999,
			systolic50: 101,
			systolic90: 114,
			systolic95: 117,
			systolic95plus: 129,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 12,
			sex: Patient.Sex.male,
			heightInMeters: 1.4750000000000001,
			systolic50: 102,
			systolic90: 115,
			systolic95: 118,
			systolic95plus: 130,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 12,
			sex: Patient.Sex.male,
			heightInMeters: 1.5269999999999999,
			systolic50: 104,
			systolic90: 117,
			systolic95: 121,
			systolic95plus: 133,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 12,
			sex: Patient.Sex.male,
			heightInMeters: 1.579,
			systolic50: 106,
			systolic90: 119,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 12,
			sex: Patient.Sex.male,
			heightInMeters: 1.6259999999999999,
			systolic50: 108,
			systolic90: 121,
			systolic95: 126,
			systolic95plus: 138,
			diastolic50: 63,
			diastolic90: 76,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 12,
			sex: Patient.Sex.male,
			heightInMeters: 1.655,
			systolic50: 109,
			systolic90: 122,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 63,
			diastolic90: 76,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 13,
			sex: Patient.Sex.male,
			heightInMeters: 1.47,
			systolic50: 103,
			systolic90: 115,
			systolic95: 119,
			systolic95plus: 131,
			diastolic50: 61,
			diastolic90: 74,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 13,
			sex: Patient.Sex.male,
			heightInMeters: 1.5,
			systolic50: 104,
			systolic90: 116,
			systolic95: 120,
			systolic95plus: 132,
			diastolic50: 60,
			diastolic90: 74,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 13,
			sex: Patient.Sex.male,
			heightInMeters: 1.5490000000000002,
			systolic50: 105,
			systolic90: 118,
			systolic95: 122,
			systolic95plus: 134,
			diastolic50: 61,
			diastolic90: 74,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 13,
			sex: Patient.Sex.male,
			heightInMeters: 1.6030000000000002,
			systolic50: 108,
			systolic90: 121,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 13,
			sex: Patient.Sex.male,
			heightInMeters: 1.6569999999999998,
			systolic50: 110,
			systolic90: 124,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 63,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 13,
			sex: Patient.Sex.male,
			heightInMeters: 1.7050000000000001,
			systolic50: 111,
			systolic90: 126,
			systolic95: 130,
			systolic95plus: 142,
			diastolic50: 64,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 13,
			sex: Patient.Sex.male,
			heightInMeters: 1.734,
			systolic50: 112,
			systolic90: 126,
			systolic95: 131,
			systolic95plus: 143,
			diastolic50: 65,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 14,
			sex: Patient.Sex.male,
			heightInMeters: 1.538,
			systolic50: 105,
			systolic90: 119,
			systolic95: 123,
			systolic95plus: 135,
			diastolic50: 60,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 14,
			sex: Patient.Sex.male,
			heightInMeters: 1.569,
			systolic50: 106,
			systolic90: 120,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 60,
			diastolic90: 74,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 14,
			sex: Patient.Sex.male,
			heightInMeters: 1.6200000000000001,
			systolic50: 109,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 14,
			sex: Patient.Sex.male,
			heightInMeters: 1.675,
			systolic50: 111,
			systolic90: 126,
			systolic95: 130,
			systolic95plus: 142,
			diastolic50: 64,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 14,
			sex: Patient.Sex.male,
			heightInMeters: 1.7269999999999999,
			systolic50: 112,
			systolic90: 127,
			systolic95: 132,
			systolic95plus: 144,
			diastolic50: 65,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 14,
			sex: Patient.Sex.male,
			heightInMeters: 1.774,
			systolic50: 113,
			systolic90: 128,
			systolic95: 133,
			systolic95plus: 145,
			diastolic50: 66,
			diastolic90: 79,
			diastolic95: 83,
			diastolic95plus: 95
		)!,
		BPNormsEntry(
			age: 14,
			sex: Patient.Sex.male,
			heightInMeters: 1.8009999999999999,
			systolic50: 113,
			systolic90: 129,
			systolic95: 134,
			systolic95plus: 146,
			diastolic50: 67,
			diastolic90: 80,
			diastolic95: 84,
			diastolic95plus: 96
		)!,
		BPNormsEntry(
			age: 15,
			sex: Patient.Sex.male,
			heightInMeters: 1.5900000000000001,
			systolic50: 108,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 61,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 15,
			sex: Patient.Sex.male,
			heightInMeters: 1.6200000000000001,
			systolic50: 110,
			systolic90: 124,
			systolic95: 129,
			systolic95plus: 141,
			diastolic50: 62,
			diastolic90: 76,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 15,
			sex: Patient.Sex.male,
			heightInMeters: 1.669,
			systolic50: 112,
			systolic90: 126,
			systolic95: 131,
			systolic95plus: 143,
			diastolic50: 64,
			diastolic90: 78,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 15,
			sex: Patient.Sex.male,
			heightInMeters: 1.722,
			systolic50: 113,
			systolic90: 128,
			systolic95: 132,
			systolic95plus: 144,
			diastolic50: 65,
			diastolic90: 79,
			diastolic95: 83,
			diastolic95plus: 95
		)!,
		BPNormsEntry(
			age: 15,
			sex: Patient.Sex.male,
			heightInMeters: 1.7719999999999998,
			systolic50: 114,
			systolic90: 129,
			systolic95: 134,
			systolic95plus: 146,
			diastolic50: 66,
			diastolic90: 80,
			diastolic95: 84,
			diastolic95plus: 96
		)!,
		BPNormsEntry(
			age: 15,
			sex: Patient.Sex.male,
			heightInMeters: 1.8159999999999998,
			systolic50: 114,
			systolic90: 130,
			systolic95: 135,
			systolic95plus: 147,
			diastolic50: 67,
			diastolic90: 81,
			diastolic95: 85,
			diastolic95plus: 97
		)!,
		BPNormsEntry(
			age: 15,
			sex: Patient.Sex.male,
			heightInMeters: 1.8419999999999999,
			systolic50: 114,
			systolic90: 130,
			systolic95: 135,
			systolic95plus: 147,
			diastolic50: 68,
			diastolic90: 81,
			diastolic95: 85,
			diastolic95plus: 97
		)!,
		BPNormsEntry(
			age: 16,
			sex: Patient.Sex.male,
			heightInMeters: 1.621,
			systolic50: 111,
			systolic90: 126,
			systolic95: 130,
			systolic95plus: 142,
			diastolic50: 63,
			diastolic90: 77,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 16,
			sex: Patient.Sex.male,
			heightInMeters: 1.6499999999999999,
			systolic50: 112,
			systolic90: 127,
			systolic95: 131,
			systolic95plus: 143,
			diastolic50: 64,
			diastolic90: 78,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 16,
			sex: Patient.Sex.male,
			heightInMeters: 1.696,
			systolic50: 114,
			systolic90: 128,
			systolic95: 133,
			systolic95plus: 145,
			diastolic50: 66,
			diastolic90: 79,
			diastolic95: 83,
			diastolic95plus: 95
		)!,
		BPNormsEntry(
			age: 16,
			sex: Patient.Sex.male,
			heightInMeters: 1.746,
			systolic50: 115,
			systolic90: 129,
			systolic95: 134,
			systolic95plus: 146,
			diastolic50: 67,
			diastolic90: 80,
			diastolic95: 84,
			diastolic95plus: 96
		)!,
		BPNormsEntry(
			age: 16,
			sex: Patient.Sex.male,
			heightInMeters: 1.7949999999999999,
			systolic50: 115,
			systolic90: 131,
			systolic95: 135,
			systolic95plus: 147,
			diastolic50: 68,
			diastolic90: 81,
			diastolic95: 85,
			diastolic95plus: 97
		)!,
		BPNormsEntry(
			age: 16,
			sex: Patient.Sex.male,
			heightInMeters: 1.8380000000000001,
			systolic50: 116,
			systolic90: 131,
			systolic95: 136,
			systolic95plus: 148,
			diastolic50: 69,
			diastolic90: 82,
			diastolic95: 86,
			diastolic95plus: 98
		)!,
		BPNormsEntry(
			age: 16,
			sex: Patient.Sex.male,
			heightInMeters: 1.8640000000000001,
			systolic50: 116,
			systolic90: 132,
			systolic95: 137,
			systolic95plus: 149,
			diastolic50: 69,
			diastolic90: 82,
			diastolic95: 86,
			diastolic95plus: 98
		)!,
		BPNormsEntry(
			age: 17,
			sex: Patient.Sex.male,
			heightInMeters: 1.6380000000000001,
			systolic50: 114,
			systolic90: 128,
			systolic95: 132,
			systolic95plus: 144,
			diastolic50: 65,
			diastolic90: 78,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 17,
			sex: Patient.Sex.male,
			heightInMeters: 1.665,
			systolic50: 115,
			systolic90: 129,
			systolic95: 133,
			systolic95plus: 145,
			diastolic50: 66,
			diastolic90: 79,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 17,
			sex: Patient.Sex.male,
			heightInMeters: 1.7090000000000001,
			systolic50: 116,
			systolic90: 130,
			systolic95: 134,
			systolic95plus: 146,
			diastolic50: 67,
			diastolic90: 80,
			diastolic95: 84,
			diastolic95plus: 96
		)!,
		BPNormsEntry(
			age: 17,
			sex: Patient.Sex.male,
			heightInMeters: 1.758,
			systolic50: 117,
			systolic90: 131,
			systolic95: 135,
			systolic95plus: 147,
			diastolic50: 68,
			diastolic90: 81,
			diastolic95: 85,
			diastolic95plus: 97
		)!,
		BPNormsEntry(
			age: 17,
			sex: Patient.Sex.male,
			heightInMeters: 1.8069999999999999,
			systolic50: 117,
			systolic90: 132,
			systolic95: 137,
			systolic95plus: 149,
			diastolic50: 69,
			diastolic90: 82,
			diastolic95: 86,
			diastolic95plus: 98
		)!,
		BPNormsEntry(
			age: 17,
			sex: Patient.Sex.male,
			heightInMeters: 1.849,
			systolic50: 118,
			systolic90: 133,
			systolic95: 138,
			systolic95plus: 150,
			diastolic50: 70,
			diastolic90: 82,
			diastolic95: 86,
			diastolic95plus: 98
		)!,
		BPNormsEntry(
			age: 17,
			sex: Patient.Sex.male,
			heightInMeters: 1.875,
			systolic50: 118,
			systolic90: 134,
			systolic95: 138,
			systolic95plus: 150,
			diastolic50: 70,
			diastolic90: 83,
			diastolic95: 87,
			diastolic95plus: 99
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 0.754,
			systolic50: 84,
			systolic90: 98,
			systolic95: 101,
			systolic95plus: 113,
			diastolic50: 41,
			diastolic90: 54,
			diastolic95: 59,
			diastolic95plus: 71
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 0.7659999999999999,
			systolic50: 85,
			systolic90: 99,
			systolic95: 102,
			systolic95plus: 114,
			diastolic50: 42,
			diastolic90: 55,
			diastolic95: 59,
			diastolic95plus: 71
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 0.78599999999999992,
			systolic50: 86,
			systolic90: 99,
			systolic95: 102,
			systolic95plus: 114,
			diastolic50: 42,
			diastolic90: 56,
			diastolic95: 60,
			diastolic95plus: 72
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 0.80799999999999994,
			systolic50: 86,
			systolic90: 100,
			systolic95: 103,
			systolic95plus: 115,
			diastolic50: 43,
			diastolic90: 56,
			diastolic95: 60,
			diastolic95plus: 72
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 0.82999999999999996,
			systolic50: 87,
			systolic90: 101,
			systolic95: 104,
			systolic95plus: 116,
			diastolic50: 44,
			diastolic90: 57,
			diastolic95: 61,
			diastolic95plus: 73
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 0.84900000000000009,
			systolic50: 88,
			systolic90: 102,
			systolic95: 105,
			systolic95plus: 117,
			diastolic50: 45,
			diastolic90: 58,
			diastolic95: 62,
			diastolic95plus: 74
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 0.86099999999999999,
			systolic50: 88,
			systolic90: 102,
			systolic95: 105,
			systolic95plus: 117,
			diastolic50: 46,
			diastolic90: 58,
			diastolic95: 62,
			diastolic95plus: 74
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.female,
			heightInMeters: 0.84900000000000009,
			systolic50: 87,
			systolic90: 101,
			systolic95: 104,
			systolic95plus: 116,
			diastolic50: 45,
			diastolic90: 58,
			diastolic95: 62,
			diastolic95plus: 74
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.female,
			heightInMeters: 0.86299999999999999,
			systolic50: 87,
			systolic90: 101,
			systolic95: 105,
			systolic95plus: 117,
			diastolic50: 46,
			diastolic90: 58,
			diastolic95: 63,
			diastolic95plus: 75
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.female,
			heightInMeters: 0.8859999999999999,
			systolic50: 88,
			systolic90: 102,
			systolic95: 106,
			systolic95plus: 118,
			diastolic50: 47,
			diastolic90: 59,
			diastolic95: 63,
			diastolic95plus: 75
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.female,
			heightInMeters: 0.91099999999999992,
			systolic50: 89,
			systolic90: 103,
			systolic95: 106,
			systolic95plus: 118,
			diastolic50: 48,
			diastolic90: 60,
			diastolic95: 64,
			diastolic95plus: 76
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.female,
			heightInMeters: 0.93700000000000006,
			systolic50: 90,
			systolic90: 104,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 49,
			diastolic90: 61,
			diastolic95: 65,
			diastolic95plus: 77
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.female,
			heightInMeters: 0.95999999999999996,
			systolic50: 91,
			systolic90: 105,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 50,
			diastolic90: 62,
			diastolic95: 66,
			diastolic95plus: 78
		)!,
		BPNormsEntry(
			age: 2,
			sex: Patient.Sex.female,
			heightInMeters: 0.97400000000000009,
			systolic50: 91,
			systolic90: 106,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 51,
			diastolic90: 62,
			diastolic95: 66,
			diastolic95plus: 78
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.female,
			heightInMeters: 0.91000000000000003,
			systolic50: 88,
			systolic90: 102,
			systolic95: 106,
			systolic95plus: 118,
			diastolic50: 48,
			diastolic90: 60,
			diastolic95: 64,
			diastolic95plus: 76
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.female,
			heightInMeters: 0.92400000000000004,
			systolic50: 89,
			systolic90: 103,
			systolic95: 106,
			systolic95plus: 118,
			diastolic50: 48,
			diastolic90: 61,
			diastolic95: 65,
			diastolic95plus: 77
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.female,
			heightInMeters: 0.94900000000000007,
			systolic50: 89,
			systolic90: 104,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 49,
			diastolic90: 61,
			diastolic95: 65,
			diastolic95plus: 77
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.female,
			heightInMeters: 0.97599999999999998,
			systolic50: 90,
			systolic90: 104,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 50,
			diastolic90: 62,
			diastolic95: 66,
			diastolic95plus: 78
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.female,
			heightInMeters: 1.0049999999999999,
			systolic50: 91,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 51,
			diastolic90: 63,
			diastolic95: 67,
			diastolic95plus: 79
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.female,
			heightInMeters: 1.0309999999999999,
			systolic50: 92,
			systolic90: 106,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 53,
			diastolic90: 64,
			diastolic95: 68,
			diastolic95plus: 80
		)!,
		BPNormsEntry(
			age: 3,
			sex: Patient.Sex.female,
			heightInMeters: 1.046,
			systolic50: 93,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 53,
			diastolic90: 65,
			diastolic95: 69,
			diastolic95plus: 81
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.female,
			heightInMeters: 0.97199999999999998,
			systolic50: 89,
			systolic90: 103,
			systolic95: 107,
			systolic95plus: 119,
			diastolic50: 50,
			diastolic90: 62,
			diastolic95: 66,
			diastolic95plus: 78
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.female,
			heightInMeters: 0.98799999999999999,
			systolic50: 90,
			systolic90: 104,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 51,
			diastolic90: 63,
			diastolic95: 67,
			diastolic95plus: 79
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.female,
			heightInMeters: 1.014,
			systolic50: 91,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 51,
			diastolic90: 64,
			diastolic95: 68,
			diastolic95plus: 80
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.female,
			heightInMeters: 1.0449999999999999,
			systolic50: 92,
			systolic90: 106,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 53,
			diastolic90: 65,
			diastolic95: 69,
			diastolic95plus: 81
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.female,
			heightInMeters: 1.0759999999999998,
			systolic50: 93,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 54,
			diastolic90: 66,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.female,
			heightInMeters: 1.105,
			systolic50: 94,
			systolic90: 108,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 55,
			diastolic90: 67,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 4,
			sex: Patient.Sex.female,
			heightInMeters: 1.1220000000000001,
			systolic50: 94,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 55,
			diastolic90: 67,
			diastolic95: 71,
			diastolic95plus: 83
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.female,
			heightInMeters: 1.036,
			systolic50: 90,
			systolic90: 104,
			systolic95: 108,
			systolic95plus: 120,
			diastolic50: 52,
			diastolic90: 64,
			diastolic95: 68,
			diastolic95plus: 80
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.female,
			heightInMeters: 1.0529999999999999,
			systolic50: 91,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 52,
			diastolic90: 65,
			diastolic95: 69,
			diastolic95plus: 81
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.female,
			heightInMeters: 1.0820000000000001,
			systolic50: 92,
			systolic90: 106,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 53,
			diastolic90: 66,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.female,
			heightInMeters: 1.115,
			systolic50: 93,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 55,
			diastolic90: 67,
			diastolic95: 71,
			diastolic95plus: 83
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.female,
			heightInMeters: 1.149,
			systolic50: 94,
			systolic90: 108,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 56,
			diastolic90: 68,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.female,
			heightInMeters: 1.181,
			systolic50: 95,
			systolic90: 109,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 69,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 5,
			sex: Patient.Sex.female,
			heightInMeters: 1.2,
			systolic50: 96,
			systolic90: 110,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 57,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.female,
			heightInMeters: 1.1000000000000001,
			systolic50: 92,
			systolic90: 105,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 54,
			diastolic90: 67,
			diastolic95: 70,
			diastolic95plus: 82
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.female,
			heightInMeters: 1.1179999999999999,
			systolic50: 92,
			systolic90: 106,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 54,
			diastolic90: 67,
			diastolic95: 71,
			diastolic95plus: 83
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.female,
			heightInMeters: 1.149,
			systolic50: 93,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 55,
			diastolic90: 68,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.female,
			heightInMeters: 1.1840000000000002,
			systolic50: 94,
			systolic90: 108,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 56,
			diastolic90: 69,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.female,
			heightInMeters: 1.2209999999999999,
			systolic50: 96,
			systolic90: 109,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.female,
			heightInMeters: 1.256,
			systolic50: 97,
			systolic90: 110,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 58,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 6,
			sex: Patient.Sex.female,
			heightInMeters: 1.2770000000000001,
			systolic50: 97,
			systolic90: 111,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 59,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.female,
			heightInMeters: 1.159,
			systolic50: 92,
			systolic90: 106,
			systolic95: 109,
			systolic95plus: 121,
			diastolic50: 55,
			diastolic90: 68,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.female,
			heightInMeters: 1.1779999999999999,
			systolic50: 93,
			systolic90: 106,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 55,
			diastolic90: 68,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.female,
			heightInMeters: 1.2109999999999999,
			systolic50: 94,
			systolic90: 107,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 56,
			diastolic90: 69,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.female,
			heightInMeters: 1.2490000000000001,
			systolic50: 95,
			systolic90: 109,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.female,
			heightInMeters: 1.288,
			systolic50: 97,
			systolic90: 110,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 58,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.female,
			heightInMeters: 1.325,
			systolic50: 98,
			systolic90: 111,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 59,
			diastolic90: 72,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 7,
			sex: Patient.Sex.female,
			heightInMeters: 1.347,
			systolic50: 99,
			systolic90: 112,
			systolic95: 115,
			systolic95plus: 127,
			diastolic50: 60,
			diastolic90: 72,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.female,
			heightInMeters: 1.21,
			systolic50: 93,
			systolic90: 107,
			systolic95: 110,
			systolic95plus: 122,
			diastolic50: 56,
			diastolic90: 69,
			diastolic95: 72,
			diastolic95plus: 84
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.female,
			heightInMeters: 1.23,
			systolic50: 94,
			systolic90: 107,
			systolic95: 111,
			systolic95plus: 123,
			diastolic50: 56,
			diastolic90: 70,
			diastolic95: 73,
			diastolic95plus: 85
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.female,
			heightInMeters: 1.2649999999999999,
			systolic50: 95,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.female,
			heightInMeters: 1.306,
			systolic50: 97,
			systolic90: 110,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 59,
			diastolic90: 72,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.female,
			heightInMeters: 1.347,
			systolic50: 98,
			systolic90: 111,
			systolic95: 115,
			systolic95plus: 127,
			diastolic50: 60,
			diastolic90: 72,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.female,
			heightInMeters: 1.385,
			systolic50: 99,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 61,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 8,
			sex: Patient.Sex.female,
			heightInMeters: 1.409,
			systolic50: 100,
			systolic90: 113,
			systolic95: 117,
			systolic95plus: 129,
			diastolic50: 61,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.female,
			heightInMeters: 1.2529999999999999,
			systolic50: 95,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 57,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.female,
			heightInMeters: 1.276,
			systolic50: 95,
			systolic90: 108,
			systolic95: 112,
			systolic95plus: 124,
			diastolic50: 58,
			diastolic90: 71,
			diastolic95: 74,
			diastolic95plus: 86
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.female,
			heightInMeters: 1.3130000000000002,
			systolic50: 97,
			systolic90: 109,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 59,
			diastolic90: 72,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.female,
			heightInMeters: 1.3559999999999999,
			systolic50: 98,
			systolic90: 111,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 60,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.female,
			heightInMeters: 1.401,
			systolic50: 99,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 60,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.female,
			heightInMeters: 1.4409999999999998,
			systolic50: 100,
			systolic90: 113,
			systolic95: 117,
			systolic95plus: 129,
			diastolic50: 61,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 9,
			sex: Patient.Sex.female,
			heightInMeters: 1.466,
			systolic50: 101,
			systolic90: 114,
			systolic95: 118,
			systolic95plus: 130,
			diastolic50: 61,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.2969999999999999,
			systolic50: 96,
			systolic90: 109,
			systolic95: 113,
			systolic95plus: 125,
			diastolic50: 58,
			diastolic90: 72,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.3219999999999998,
			systolic50: 97,
			systolic90: 110,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 59,
			diastolic90: 73,
			diastolic95: 75,
			diastolic95plus: 87
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.3630000000000002,
			systolic50: 98,
			systolic90: 111,
			systolic95: 114,
			systolic95plus: 126,
			diastolic50: 59,
			diastolic90: 73,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4099999999999999,
			systolic50: 99,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 60,
			diastolic90: 73,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4580000000000002,
			systolic50: 101,
			systolic90: 113,
			systolic95: 117,
			systolic95plus: 129,
			diastolic50: 61,
			diastolic90: 73,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5019999999999998,
			systolic50: 102,
			systolic90: 115,
			systolic95: 119,
			systolic95plus: 131,
			diastolic50: 61,
			diastolic90: 73,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.528,
			systolic50: 103,
			systolic90: 116,
			systolic95: 120,
			systolic95plus: 132,
			diastolic50: 62,
			diastolic90: 73,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.3559999999999999,
			systolic50: 98,
			systolic90: 111,
			systolic95: 115,
			systolic95plus: 127,
			diastolic50: 60,
			diastolic90: 74,
			diastolic95: 76,
			diastolic95plus: 88
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.383,
			systolic50: 99,
			systolic90: 112,
			systolic95: 116,
			systolic95plus: 128,
			diastolic50: 60,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4280000000000002,
			systolic50: 101,
			systolic90: 113,
			systolic95: 117,
			systolic95plus: 129,
			diastolic50: 60,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4780000000000002,
			systolic50: 102,
			systolic90: 114,
			systolic95: 118,
			systolic95plus: 130,
			diastolic50: 61,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.528,
			systolic50: 104,
			systolic90: 116,
			systolic95: 120,
			systolic95plus: 132,
			diastolic50: 62,
			diastolic90: 74,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5730000000000002,
			systolic50: 105,
			systolic90: 118,
			systolic95: 123,
			systolic95plus: 135,
			diastolic50: 63,
			diastolic90: 75,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6000000000000001,
			systolic50: 106,
			systolic90: 120,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 64,
			diastolic90: 75,
			diastolic95: 77,
			diastolic95plus: 89
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4280000000000002,
			systolic50: 102,
			systolic90: 114,
			systolic95: 118,
			systolic95plus: 130,
			diastolic50: 61,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4550000000000001,
			systolic50: 102,
			systolic90: 115,
			systolic95: 119,
			systolic95plus: 131,
			diastolic50: 61,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4990000000000001,
			systolic50: 104,
			systolic90: 116,
			systolic95: 120,
			systolic95plus: 132,
			diastolic50: 61,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.548,
			systolic50: 105,
			systolic90: 118,
			systolic95: 122,
			systolic95plus: 134,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 78,
			diastolic95plus: 90
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5959999999999999,
			systolic50: 107,
			systolic90: 120,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6380000000000001,
			systolic50: 108,
			systolic90: 122,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 65,
			diastolic90: 76,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6640000000000001,
			systolic50: 108,
			systolic90: 122,
			systolic95: 126,
			systolic95plus: 138,
			diastolic50: 65,
			diastolic90: 76,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.4809999999999999,
			systolic50: 104,
			systolic90: 116,
			systolic95: 121,
			systolic95plus: 133,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.506,
			systolic50: 105,
			systolic90: 117,
			systolic95: 122,
			systolic95plus: 134,
			diastolic50: 62,
			diastolic90: 75,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5469999999999999,
			systolic50: 106,
			systolic90: 119,
			systolic95: 123,
			systolic95plus: 135,
			diastolic50: 63,
			diastolic90: 75,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5919999999999999,
			systolic50: 107,
			systolic90: 121,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 79,
			diastolic95plus: 91
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6369999999999998,
			systolic50: 108,
			systolic90: 122,
			systolic95: 126,
			systolic95plus: 138,
			diastolic50: 65,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6780000000000002,
			systolic50: 108,
			systolic90: 123,
			systolic95: 126,
			systolic95plus: 138,
			diastolic50: 65,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.702,
			systolic50: 109,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 66,
			diastolic90: 76,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.506,
			systolic50: 105,
			systolic90: 118,
			systolic95: 123,
			systolic95plus: 135,
			diastolic50: 63,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.53,
			systolic50: 106,
			systolic90: 118,
			systolic95: 123,
			systolic95plus: 135,
			diastolic50: 63,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.569,
			systolic50: 107,
			systolic90: 120,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6130000000000002,
			systolic50: 108,
			systolic90: 122,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 65,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6569999999999998,
			systolic50: 109,
			systolic90: 123,
			systolic95: 126,
			systolic95plus: 138,
			diastolic50: 66,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6969999999999998,
			systolic50: 109,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 66,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.7209999999999999,
			systolic50: 109,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 66,
			diastolic90: 77,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5169999999999999,
			systolic50: 105,
			systolic90: 118,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.54,
			systolic50: 106,
			systolic90: 119,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.579,
			systolic50: 107,
			systolic90: 121,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6230000000000002,
			systolic50: 108,
			systolic90: 122,
			systolic95: 126,
			systolic95plus: 138,
			diastolic50: 65,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6669999999999998,
			systolic50: 109,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 66,
			diastolic90: 77,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.706,
			systolic50: 109,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 67,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.73,
			systolic50: 109,
			systolic90: 124,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 67,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5209999999999999,
			systolic50: 106,
			systolic90: 119,
			systolic95: 124,
			systolic95plus: 136,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5449999999999999,
			systolic50: 107,
			systolic90: 120,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5840000000000001,
			systolic50: 108,
			systolic90: 122,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 65,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6280000000000001,
			systolic50: 109,
			systolic90: 123,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 66,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.671,
			systolic50: 109,
			systolic90: 124,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 66,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.7109999999999999,
			systolic50: 110,
			systolic90: 124,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 67,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.734,
			systolic50: 110,
			systolic90: 124,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 67,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.524,
			systolic50: 107,
			systolic90: 120,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.5469999999999999,
			systolic50: 108,
			systolic90: 121,
			systolic95: 125,
			systolic95plus: 137,
			diastolic50: 64,
			diastolic90: 76,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.587,
			systolic50: 109,
			systolic90: 123,
			systolic95: 126,
			systolic95plus: 138,
			diastolic50: 65,
			diastolic90: 77,
			diastolic95: 80,
			diastolic95plus: 92
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6299999999999999,
			systolic50: 110,
			systolic90: 124,
			systolic95: 127,
			systolic95plus: 139,
			diastolic50: 66,
			diastolic90: 77,
			diastolic95: 81,
			diastolic95plus: 93
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.6740000000000002,
			systolic50: 110,
			systolic90: 124,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 66,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.7130000000000001,
			systolic50: 110,
			systolic90: 125,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 66,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!,
		BPNormsEntry(
			age: 1,
			sex: Patient.Sex.female,
			heightInMeters: 1.7369999999999999,
			systolic50: 111,
			systolic90: 125,
			systolic95: 128,
			systolic95plus: 140,
			diastolic50: 67,
			diastolic90: 78,
			diastolic95: 82,
			diastolic95plus: 94
		)!
    )!
}
