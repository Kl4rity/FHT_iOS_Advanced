//
//  ViewController.swift
//  localApp
//
//  Created by Clemens Stift on 26.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textLabel.text = NSLocalizedString("welcome", comment: "String")
        // Do any additional setup after loading the view, typically from a nib.
    }
}

