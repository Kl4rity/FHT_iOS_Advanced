//
//  ViewController.swift
//  lectureApp
//
//  Created by Clemens Stift on 12.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var resultField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (granted, error) in
            // Error handling
        })
        UNUserNotificationCenter.current().delegate = self
    }
    
    @IBAction func clickEventListener(_ sender: Any) {
        sendNotification(delay: 0.5)
    }
    
    func sendNotification(delay:Double){
        let content = UNMutableNotificationContent()
        content.title = "This is a Notification"
        content.subtitle = "What kind of Notification?"
        content.body = "A great notification."
        content.badge = 1
        
        let repeatAction = UNNotificationAction(identifier:"repeat",
                                                title:"Repeat",options:[])
        
        let changeAction = UNTextInputNotificationAction(identifier: "change",
                                                         title: "Change Message", options: [])
        
        let category = UNNotificationCategory(identifier: "actionCategory",
                                              actions: [repeatAction, changeAction],
                                              intentIdentifiers: [],
                                              options: [.hiddenPreviewsShowTitle,
                                                        .hiddenPreviewsShowSubtitle])
        
        content.categoryIdentifier = "actionCategory"
        
        UNUserNotificationCenter.current().setNotificationCategories(
            [category])
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: delay,
                                                        repeats: false)
        
        let requestIdentifier = "demoNotification"
        let request = UNNotificationRequest(identifier: requestIdentifier,
                                            content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request,
                                               withCompletionHandler: { (error) in
                                                // Handle error
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive
        response: UNNotificationResponse, withCompletionHandler completionHandler:
        @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "repeat":
            self.sendNotification(delay: 10)
        case "change":
            let textResponse = response
                as! UNTextInputNotificationResponse
            resultField.text = textResponse.userText
        default:
            break
        }
        completionHandler()
    }
}
