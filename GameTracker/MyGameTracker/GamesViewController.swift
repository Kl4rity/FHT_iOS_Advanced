//
//  GamesViewController.swift
//  MyGameTracker
//
//  Created by Clemens Stift on 05.12.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit
import CoreData

class GamesViewController : UITableViewController {
    
    var appDelegate : AppDelegate!
    var managedContext : NSManagedObjectContext!
    var playerName : String!
    var player : Player!
    
    // Fetch the games
    var games : Array<Any> = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = NSLocalizedString("GameList-Title", comment: "")

        
        setUpCoreData()
        fetchPlayer()
        fetchData()
    }
    
    func setUpCoreData(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addGameToPlayer"){
            var viewController = segue.destination as! AddGameViewController
            viewController.currentPlayerName = playerName
        }
    }
    
    func fetchPlayer (){
        let playerFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        playerFetchRequest.predicate = NSPredicate(format: "name == %@", playerName)
        playerFetchRequest.fetchLimit = 1
        player = (try! managedContext.fetch(playerFetchRequest) as! [Player])[0]
    }
    
    func fetchData(){
        games = [Game]()
        let gamesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
//        gamesFetch.predicate = NSPredicate(format:"playedBy == %@", player)
        var allGames = try! managedContext.fetch(gamesFetch) as! [Game]
        for game in allGames {
            let playerList = game.playedBy ?? NSSet()
            if (playerList.contains(player)){
                games.append(game)
            }
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let game = games[indexPath.row] as! Game
            displayAlertView(gameToBeRemoved: game, playerToBeRemovedFrom: player)
        }
    }
    
    func displayAlertView(gameToBeRemoved: Game, playerToBeRemovedFrom: Player){
         let alertController = UIAlertController(title: NSLocalizedString("GameList-removeGameTitle", comment: ""), message: NSLocalizedString("GameList-removeGameMessage", comment: ""), preferredStyle: .alert)
        let yesAction = UIAlertAction(title: NSLocalizedString("GameList-confirm", comment: ""), style: .default){(action)
            in
            gameToBeRemoved.removeFromPlayedBy(playerToBeRemovedFrom)
            playerToBeRemovedFrom.removeFromPlays(gameToBeRemoved)
            self.appDelegate.saveContext()
            self.fetchData()
        }
        let noAction = UIAlertAction(title:NSLocalizedString("GameList-cancel", comment: ""), style: .default){(action)
            in
            return
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated:true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        
        let game = games[indexPath.row]
        cell.game = game as? Game
        
        return cell
    }
    
}
