//
//  ViewController.swift
//  CoreData
//
//  Created by Clemens Stift on 27.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    }


}

