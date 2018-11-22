//
//  ViewController.swift
//  lectureApp
//
//  Created by Clemens Stift on 12.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate, UIActionSheetDelegate {

    @IBOutlet weak var userTextEntry: UITextField!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    @IBAction func clickEventListener(_ sender: Any) {
        topLabel.text = "Hello " + userTextEntry.text!;
        scheduleNotification(myIdentifier: "myNotficiation", myContent: generateNotificationContent(), myTrigger: generateNotificationTrigger())
        
        
        let alertController = UIAlertController(title: "Test", message: "Testmessage is testable", preferredStyle: .actionSheet)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (UIAlertAction) in
            print("User pressed yess.")
        }
        
        let noAction = UIAlertAction(title: "No", style: .destructive) { (UIAlertAction) in
            print("User pressed no.")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
        
//        let actionSheet = UIActionSheet(title: "Action", delegate: (self as! UIActionSheetDelegate), cancelButtonTitle: "Nope", destructiveButtonTitle: "OK")
//        actionSheet.actionSheetStyle = .default
//        actionSheet.show(in: self.view)
    }
    
//    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
//        if buttonIndex == 0 {
//            let alertView = UIAlertView(title: "Test", message: "Hey this is a test", delegate: self, cancelButtonTitle: "Ok")
//            alertView.alertViewStyle = .default
//            alertView.show()
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Error handling here.
        }
        
        UNUserNotificationCenter.current().delegate = self
    }
    
//    let repeatAction = UNNotificationAction(identifier:"repeat",
//                                            title:"Repeat",options:[])
//
//    let changeAction = UNTextInputNotificationAction(identifier: "change",
//                                                     title: "Change Message", options: [])
//
//    let category = UNNotificationCategory(identifier: "actionCategory",
//                                          actions: [repeatAction, changeAction],
//                                          intentIdentifiers: [], options: [])
//
//    content.categoryIdentifier = "actionCategory"
//
//    UNUserNotificationCenter.current().setNotificationCategories([category])

    func generateNotificationContent() -> UNMutableNotificationContent{
        let content = UNMutableNotificationContent()
        content.title = "My App"
        content.subtitle = userTextEntry.text!
        content.body = "A notification set by you."
        content.badge = 1
        return content
    }
    
    func generateNotificationTrigger() -> UNTimeIntervalNotificationTrigger {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        return trigger
    }
    
    func scheduleNotification(myIdentifier: String, myContent:UNNotificationContent, myTrigger: UNNotificationTrigger){
        
        let request = UNNotificationRequest(identifier: myIdentifier, content: myContent, trigger: myTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            (error) in
            // Handle Error.
        })
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //
        
        completionHandler([.alert, .sound, .badge])
    }
}
