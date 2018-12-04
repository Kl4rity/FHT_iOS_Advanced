//
//  TaskCell.swift
//  MyCoreDataApplication
//
//  Created by Clemens Stift on 28.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import Foundation
import UIKit

class PlayerCell : UITableViewCell {
    @IBOutlet weak var itemText: UILabel!
    
    var player: Player?{
        didSet{
            guard let player = player else {return}
            
            itemText.text = player.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
