//
//  AppDelegate.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/9/21.
//

import UIKit
import UserNotifications
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        regisetLocal()
        scheduleLocal()
        scheduleBGTasks()
        return true
    }


    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: Background Task
    
    private func scheduleBGTasks() {
        /*
         registering the background task
         */
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.jantiks.fetchCars", using: nil) { (task) in
            self.handleAppRefreshTask(task: task)
        }
    }
    
    private func handleAppRefreshTask(task: BGTask) {
        /*
         handling the refresh task
         */
        task.expirationHandler = {
//            Parser.invalidateParser()
        }
        // code to be here
    }
    
    func scheduleBGCarsFetch() {
        /*
         scheduleing the background task
         */
        
        let carsFetchTask = BGAppRefreshTaskRequest(identifier: "com.jantiks.fetchCars")
        carsFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        
        do {
            try BGTaskScheduler.shared.submit(carsFetchTask)
        } catch  {
            print("unable to submit task \(error.localizedDescription)")
        }
    }
    
    // MARK: UserNotifications
    private func regisetLocal() {
        /*
         registers local notification , asks user for permissions.
         */
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("granted")
            } else {
                print("error")
            }
        }
    }
    
    private func scheduleLocal() {
        /*
         schedules local notifications
         */
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Testing title"
        content.body = "Du txa es tiko"
        print("passed")
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }

}

