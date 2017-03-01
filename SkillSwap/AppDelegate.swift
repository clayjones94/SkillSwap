//
//  AppDelegate.swift
//  SkillSwap
//
//  Created by Clay Jones on 1/27/17.
//  Copyright © 2017 SkillSwap. All rights reserved.
//

import UIKit
import SideMenu
import Fabric
import Crashlytics
import DigitsKit
import UserNotifications
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    var navController: UINavigationController?
    
    var strDeviceToken : String = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        registerForRemoteNotification()
        Fabric.with([Crashlytics.self, Digits.self])
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainViewController = SSMainViewController()
        mainViewController.view.backgroundColor = .white
        
        navController = UINavigationController.init(rootViewController: mainViewController)
        
        let sideMenuController = SSSideMenuViewController()
        sideMenuController.mainViewController = mainViewController
        sideMenuController.meetupViewController = SSMeetupsViewController()
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: sideMenuController)
        menuLeftNavigationController.view.backgroundColor = .white
        menuLeftNavigationController.leftSide = true
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        SideMenuManager.menuFadeStatusBar = true
        SideMenuManager.menuAnimationBackgroundColor = .white
        SideMenuManager.menuAddPanGestureToPresent(toView: (mainViewController.navigationController?.navigationBar)!)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: (mainViewController.navigationController?.view)!)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func setUpSideMenu () {

    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        let chars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
        var token = ""
        
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", arguments: [chars[i]])
        }
        
        print("Device Token = ", token)
        self.strDeviceToken = token
        SSCurrentUser.sharedInstance.apnsToken = token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Error = ",error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
    }

    func registerForRemoteNotification() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
        else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    enum NotificationType {
        case acceptTeacher
        case other
    }
    
    //Called when a notification is delivered to a foreground app.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("User Info = ",notification.request.content.userInfo)
        let info: [AnyHashable : Any] = notification.request.content.userInfo
//        let message = info["messageFrom"] as! String
        let typeInt = info["type"] as! Int
        var type: NotificationType = .other
        switch typeInt {
        case 1:
            type = .acceptTeacher
        default:
            type = .other
        }
        if (type == .acceptTeacher){
            let notificationName = Notification.Name(LEARNING_ACCEPTED_NOTIFICATION)
            NotificationCenter.default.post(name: notificationName, object: nil)
        }
        
        completionHandler([.alert, .badge, .sound])
    }
    
    //Called to let your app know which action was selected by the user for a given notification.
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = ",response.notification.request.content.userInfo)
        completionHandler()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

