//
//  TaskCell.swift
//  MyCoreDataApplication
//
//  Created by Clemens Stift on 28.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import Foundation
import UIKit

class TaskCell : UITableViewCell {
    @IBOutlet weak var itemText: UILabel!
    
    var task: Task?{
        didSet{
            guard let task = task else {return}
            
            itemText.text = task.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
