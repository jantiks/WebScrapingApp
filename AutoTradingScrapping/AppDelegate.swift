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

    var dataManager: DataManager? = nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
        
        dataManager = DataManager()
        guard let searchDatas = dataManager?.loadSavedData() else { return }
        guard let searchData = searchDatas.randomElement() else { return }
        let params = SearchParams(brand: searchData.brand, model: searchData.model, zipCode: searchData.zipCode, startYear: searchData.startYear, endYear: searchData.endYear, page: 0)
        
        // parsing the data
        
        let parser = Parser(params: params)
        parser.parseData { [weak self] result in
            print("is parsing in bg")
            guard let superSelf = self else { return }
            switch result {
            case.success(let parsedCars):
                let result = superSelf.getResult(searchData)

                // checking if the new parsed data has changes
                for parsedCar in parsedCars {
                    for car in result {
                        if (parsedCar.phoneNumber == car.phoneNumber) &&
                            (parsedCar.price == car.price) &&
                            (parsedCar.title == car.price) {
                            // if no change continue
                            continue

                        } else {
                            // if are changes make local notifications
                            self?.regisetLocal()
                            self?.scheduleLocal(title: parsedCar.title, phoneNumber: parsedCar.phoneNumber, price: parsedCar.price)
                            task.setTaskCompleted(success: true)
                        }
                    }
                }
            case.failure(_):
                print("error")
                task.setTaskCompleted(success: false)
                
            }
            
        }
        

        
        scheduleBGTasks()

    }
    
    func scheduleBGCarsFetch() {
        /*
         scheduleing the background task
         */
        
        let carsFetchTask = BGAppRefreshTaskRequest(identifier: "com.jantiks.fetchCars")
        carsFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 30)
        
        do {
            try BGTaskScheduler.shared.submit(carsFetchTask)
        } catch  {
            print("unable to submit task \(error.localizedDescription)")
        }
    }
    
    private func getResult(_ searchData: SearchData) -> [Car] {
        /*
         changing the CarsData array to Car array
         @parameters searchData
         @return [Car]
         */
        guard var result = searchData.result?.allObjects as? [CarsData] else { fatalError() }
        result = result.sorted {
            return $0.position < $1.position
        }
        var returnResult = [Car]()
        
        for res in result {
            let car = Car(title: res.title, price: res.price, phoneNumber: res.phoneNumber)
            returnResult.append(car)
        }
        
        return returnResult
        
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
    
    private func scheduleLocal(title: String, phoneNumber: String, price: String ) {
        /*
         schedules local notifications
         */
        
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "\(phoneNumber)   \(price)"
        print("passed")
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }

}

