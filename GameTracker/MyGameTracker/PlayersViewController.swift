//
//  ViewController.swift
//  MyCoreDataApplication
//
//  Created by Clemens Stift on 28.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit
import CoreData

class PlayersViewController: UITableViewController {
    
    var appDelegate : AppDelegate!
    var managedContext : NSManagedObjectContext!
    
    // Fetch the players
    var players : Array<Any> = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = NSLocalizedString("PlayerList-Title", comment: "")
        
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
        let playerFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        players = try! managedContext.fetch(playerFetch)
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let player = players[indexPath.row]
            managedContext.delete(player as! Player)
            appDelegate.saveContext()
            fetchData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! PlayerCell
        
        let player = players[indexPath.row]
        cell.player = player as? Player
        
        return cell
    }
    
}

