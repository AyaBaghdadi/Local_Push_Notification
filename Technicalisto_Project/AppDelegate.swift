//
//  Created by Technicalisto.
//

import UIKit
import UserNotifications
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//---------------------------------------------------------------------------------------------

    let gcmMessageIDKey = "gcm.message_id"

//---------------------------------------------------------------------------------------------

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        application.beginBackgroundTask(withName: "showNotification", expirationHandler: nil)
        let center = UNUserNotificationCenter.current()
        center.delegate = self as! UNUserNotificationCenterDelegate
        
        return true
    }

//---------------------------------------------------------------------------------------------

    func applicationDidEnterBackground(_ application: UIApplication) {
        application.beginBackgroundTask {} // allows to run background tasks
    }

//---------------------------------------------------------------------------------------------

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

//---------------------------------------------------------------------------------------------

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo

        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

        completionHandler([.alert,.badge, .sound])

        print(userInfo)

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        print(userInfo)

        completionHandler()
    }
}

//---------------------------------------------------------------------------------------------

