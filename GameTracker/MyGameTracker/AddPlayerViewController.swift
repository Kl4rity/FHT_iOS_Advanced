//
//  AddTaskViewController.swift
//  MyCoreDataApplication
//
//  Created by Clemens Stift on 28.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddPlayerViewController: UIViewController {
    
    @IBOutlet weak var playerTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var appDelegate : AppDelegate!
    var managedContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = NSLocalizedString("AddPlayer-Title", comment: "")
        addButton.setTitle(NSLocalizedString("AddPlayer-AddButtonTitle", comment: "") , for: .normal)
        
        setUpCoreData()
    }
    
    func setUpCoreData(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        let taskEntity = NSEntityDescription.entity(forEntityName:"Player", in: managedContext)!
        let player = NSManagedObject(entity: taskEntity, insertInto: managedContext)
        player.setValue(playerTextField.text, forKeyPath: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return
        }
        
        playerTextField.text = ""
    }
    
}
