
# Technicalisto

## How to Add Local Push Notification With timeInterval & Test On Simulator


1. In Project Target ( Signing & Capapilities ) Add Capapility :

       1. Background Modes : Check -> [ Bachground fetch , Remote notifications , Background processing ]
    
       2. Push Notification
    
//---------------------------------------------------------------------------------------------

2. In App Delegate Import : 

       import UserNotifications
    
       import BackgroundTasks
    
//---------------------------------------------------------------------------------------------

3. Add Settings of Push Notification ->

  |. Define gcmMessageIDKey : 

        let gcmMessageIDKey = "gcm.message_id"
    
  ||. Add Delegate of UNUserNotificationCenterDelegate for handle message :

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

4. In App Delegate add method :

       func applicationDidEnterBackground(_ application: UIApplication) {
           application.beginBackgroundTask {} // Allows to run background tasks
       }
    
//---------------------------------------------------------------------------------------------

5. In App Delegate Inside method didFinishLaunchingWithOptions add :

       application.beginBackgroundTask(withName: "showNotification", expirationHandler: nil)
    
       let center = UNUserNotificationCenter.current()
    
       center.delegate = self as! UNUserNotificationCenterDelegate
    
//---------------------------------------------------------------------------------------------
    
6. Call this method to take a permission for use push notification :

       func TakeLocalNotificationPermisiion(){
          UNUserNotificationCenter.current().requestAuthorization(options: [.alert , .badge , .sound]) { (granted, error) in
             if granted {
                 print("User gave permissions for local Notifications")
             }else{ 

             }
         }
         }
    
//---------------------------------------------------------------------------------------------
   
7. You Can Test By The following lines :

        let content = UNMutableNotificationContent()
        
        content.title = "Technicalisto"
        
        content.subtitle = "Test Local Push Notification On Simulator"
        
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)


### Thanks

