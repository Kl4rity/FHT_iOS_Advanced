//
//  MatchCell.swift
//  MyGameTracker
//
//  Created by Clemens Stift on 06.12.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import Foundation
import UIKit

class MatchCell : UITableViewCell {

    @IBOutlet weak var didWin: UILabel!
    @IBOutlet weak var scoreField: UILabel!
    
    let dateFormatter = DateFormatter()
    
    var match: Match?{
        didSet{
            guard let match = match else {return}
            didWin.text = match.won ? NSLocalizedString("MatchCell-Won", comment: "") : NSLocalizedString("MatchCell-Lost", comment: "")
            scoreField.text = String(match.userScore) + " : " + String(match.opponentScore)
        }
    }    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
