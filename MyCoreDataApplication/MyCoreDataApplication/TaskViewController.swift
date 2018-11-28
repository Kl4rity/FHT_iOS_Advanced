//
//  ViewController.swift
//  MyCoreDataApplication
//
//  Created by Clemens Stift on 28.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UITableViewController {
    
    var appDelegate : AppDelegate!
    var managedContext : NSManagedObjectContext!
    
    // Fetch the players
    var tasks : Array<Any> = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = NSLocalizedString("TaskList-Title", comment: "")
        
        setUpCoreData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func setUpCoreData(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func fetchData(){
        let taskFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        tasks = try! managedContext.fetch(taskFetch)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            managedContext.delete(task as! Task)
            appDelegate.saveContext()
            fetchData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        let task = tasks[indexPath.row]
        cell.task = task as? Task
        
        return cell
    }
    
}

