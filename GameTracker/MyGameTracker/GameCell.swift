//
//  GameCell.swift
//  MyGameTracker
//
//  Created by Clemens Stift on 05.12.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import Foundation
import UIKit

class GameCell : UITableViewCell {
    
    @IBOutlet weak var titleField: UILabel!
    
    var game: Game?{
        didSet{
            guard let game = game else {return}
            
            titleField.text = game.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
