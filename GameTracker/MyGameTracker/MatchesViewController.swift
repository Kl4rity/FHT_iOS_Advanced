//
//  GamesViewController.swift
//  MyGameTracker
//
//  Created by Clemens Stift on 05.12.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit
import CoreData

class MatchesViewController : UITableViewController {
    
    var appDelegate : AppDelegate!
    var managedContext : NSManagedObjectContext!
    var player : Player!
    var game : Game!
    
    var matches : Array<Match> = Array<Match>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NSLocalizedString("MatchList-Title", comment: "")
        
        setUpCoreData()
        fetchData()
    }
    
    func setUpCoreData(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editExistingMatchOfGame"){
            let viewController = segue.destination as! AddEditMatchViewController
            let senderCell = sender as! MatchCell
            viewController.selectedMatch = senderCell.match
            viewController.isCreateNew = false
            viewController.gamePlayed = game
            viewController.oponentPlayed = player
        }
        
        if(segue.identifier == "addNewMatchToGame"){
            let viewController = segue.destination as! AddEditMatchViewController
            viewController.isCreateNew = true
            viewController.gamePlayed = game
            viewController.oponentPlayed = player
        }
        
    }
    
    func fetchData(){
        matches = [Match]()
        let matchFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Match")
        let allMatches = (try! managedContext.fetch(matchFetchRequest) as! [Match])

        var matchesPlayedByPlayer = [Match]()
        for match in allMatches {
            if (match.opponent == player){
                matchesPlayedByPlayer.append(match)
            }
        }
        
        for match in matchesPlayedByPlayer {
            if(match.game == game){
                matches.append(match)
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let match = matches[indexPath.row]
            displayAlertView(matchToBeRemoved: match)
        }
    }
    
    func displayAlertView(matchToBeRemoved: Match){
        let alertController = UIAlertController(title: NSLocalizedString("MatchList-removeMatchTitle", comment: ""), message: NSLocalizedString("MatchList-removeMatchMessage", comment: ""), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: NSLocalizedString("MatchList-confirm", comment: ""), style: .default){(action)
            in
            self.managedContext.delete(matchToBeRemoved)
            self.appDelegate.saveContext()
            self.fetchData()
        }
        let noAction = UIAlertAction(title:NSLocalizedString("MatchList-cancel", comment: ""), style: .default){(action)
            in
            return
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated:true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath) as! MatchCell
        
        let match = matches[indexPath.row]
        cell.match = match
        
        return cell
    }
    
}
