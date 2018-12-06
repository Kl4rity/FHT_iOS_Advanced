//
//  AddGameViewController.swift
//  MyGameTracker
//
//  Created by Clemens Stift on 05.12.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var appDelegate : AppDelegate!
    var managedContext : NSManagedObjectContext!
    var pickerData : [String] = [String]()
    var currentPlayerName : String!
    
    
    @IBOutlet weak var addGameTextField: UITextField!
    @IBOutlet weak var addGameButton: UIButton!
    @IBOutlet weak var gamePicker: UIPickerView!

override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = NSLocalizedString("AddGame-Title", comment: "")
        addGameButton.setTitle(NSLocalizedString("AddGame-AddButtonTitle", comment: "") , for: .normal)
    
        setUpCoreData()
        fetchGamesData()
    
        self.gamePicker.delegate = self
        self.gamePicker.dataSource = self
    
    }

    func setUpCoreData(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func fetchGamesData(){
        // Reset the Array.
        pickerData = [String]()
        
        let gameFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let games = try! managedContext.fetch(gameFetchRequest) as! [Game]
        for game in games {
            pickerData.append(game.name!)
        }
        
        pickerData.insert(NSLocalizedString("AddGame-AddButtonTitle", comment: ""), at: 0)
        gamePicker.reloadAllComponents()
    }

    @IBAction func addGame(_ sender: Any) {
        if(gamePicker.selectedRow(inComponent: 0) == 0){
            createNewGame()
        } else {
            let selectedGameName = pickerData[gamePicker.selectedRow(inComponent: 0)]
            connectPlayerToGame(playerName: currentPlayerName, gameName: selectedGameName)
        }
    }
    
    func createNewGame(){
        let gameEntity = NSEntityDescription.entity(forEntityName:"Game", in: managedContext)!
        let game = NSManagedObject(entity: gameEntity, insertInto: managedContext)
        game.setValue(addGameTextField.text, forKeyPath: "name")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return
        }
        addGameTextField.text = ""
        
        fetchGamesData()
    }
    
    func connectPlayerToGame(playerName:String , gameName:String){
//        let playerEntity = NSEntityDescription.entity(forEntityName:"Player", in: managedContext)!
//        let gameEntity = NSEntityDescription.entity(forEntityName:"Game", in: managedContext)!
        
        // Fetch game
        let gameFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        gameFetchRequest.predicate = NSPredicate(format:"name == %@", gameName)
        gameFetchRequest.fetchLimit = 1
        let game = (try! managedContext.fetch(gameFetchRequest) as! [Game])[0]
        
        // Fetch Player
        let playerFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        playerFetchRequest.predicate = NSPredicate(format: "name == %@", playerName)
        playerFetchRequest.fetchLimit = 1
        let player = (try! managedContext.fetch(playerFetchRequest) as! [Player])[0]
        
        if(!(player.plays?.contains(game))!){
            player.addToPlays(game)
        }
        
        if(!(game.playedBy?.contains(player))!){
            game.addToPlayedBy(player)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row == 0 && component == 0){
            addGameTextField.isEnabled = true
            addGameButton.setTitle(NSLocalizedString("AddGame-AddButtonTitle", comment: "") , for: .normal)
        } else {
            addGameTextField.isEnabled = false
            addGameButton.setTitle(NSLocalizedString("AddGame-ConnectButtonTitle", comment: "") , for: .normal)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

}
