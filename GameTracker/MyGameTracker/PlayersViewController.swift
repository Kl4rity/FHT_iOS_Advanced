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
            let player = players[indexPath.row] as! Player
            displayAlertView(playerToBeRemoved: player)
        }
    }
    
    func displayAlertView(playerToBeRemoved: Player){
        let alertController = UIAlertController(title: NSLocalizedString("PlayerList-removePlayerTitle", comment: ""), message: NSLocalizedString("PlayerList-removePlayerMessage", comment: ""), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: NSLocalizedString("PlayerList-confirm", comment: ""), style: .default){(action)
            in
            self.managedContext.delete(playerToBeRemoved)
            self.appDelegate.saveContext()
            self.fetchData()
        }
        let noAction = UIAlertAction(title:NSLocalizedString("PlayerList-cancel", comment: ""), style: .default){(action)
            in
            return
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated:true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "playerSelected"){
            var viewController = segue.destination as! GamesViewController
            var senderCell = sender as! PlayerCell
            viewController.playerName = senderCell.itemText.text
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        
        let player = players[indexPath.row]
        cell.player = player as? Player
        
        return cell
    }
    
}

