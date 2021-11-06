//
//  ViewController.swift
//
//  Created by Technicalisto.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.TakeLocalNotificationPermisiion()
        
    }
    
    func TakeLocalNotificationPermisiion(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge , .sound]) { (granted, error) in
            if granted {
                print("User gave permissions for local Notifications")
            }else{

            }
        }
    }
    
    @IBAction func startTapped(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Technicalisto"
        
        content.subtitle = "Test Local Push Notification On Simulator"
        
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)

    }

    
}




