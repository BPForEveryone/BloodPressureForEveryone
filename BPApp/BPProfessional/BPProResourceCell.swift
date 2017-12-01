//
//  BPProResourceCell.swift
//  BPApp
//
//  Created by Andrew Hu on 12/1/17.
//  Copyright © 2017 BlackstoneBuilds. All rights reserved.
//

import Foundation
import UIKit

public class BPProResourceCell: UITableViewCell {
    
    // Creating this outlet from the storyboard immediately results in yellow triangle in the Table Cell references, possible corrupted metadata
    // TODO: Needs a fix in the storyboard or metadata
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
}
