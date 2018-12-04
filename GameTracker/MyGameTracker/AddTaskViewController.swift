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

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var flavorTextLabel: UILabel!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var appDelegate : AppDelegate!
    var managedContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = NSLocalizedString("AddPlayer-Title", comment: "")
        flavorTextLabel.text = NSLocalizedString("AddPlayer-FlavorText", comment: "")
        addButton.setTitle(NSLocalizedString("AddPlayer-AddButtonTitle", comment: "") , for: .normal)
        
        setUpCoreData()
    }
    
    func setUpCoreData(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func addTask(_ sender: Any) {
        
        let taskEntity = NSEntityDescription.entity(forEntityName:"Player", in: managedContext)!
        let task = NSManagedObject(entity: taskEntity, insertInto: managedContext)
        task.setValue(taskTextField.text, forKeyPath: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return
        }
        
        taskTextField.text = ""
    }
    
    
    
}
