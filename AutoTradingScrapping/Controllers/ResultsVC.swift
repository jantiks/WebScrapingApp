//
//  ResultsVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit
import CoreData
import UserNotifications
import WebKit

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    // instance variables
    private var dataManager: DataManager? = nil
    private var timer = Timer()
    
    var brandValue = ""
    var modelValue = ""
    var zipCode = ""
    var startYear = ""
    var endYear = ""
    
        
    private var Cars = [Car]()
    private var oldResults: [Car]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func loadView() {
        super.loadView()
        let params = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, time: 180, page: 0)
        dataManager = DataManager()
        dataManager?.setParams(params: params) // passing parameter
        parseData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    
    //MARK: UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError("couldn't load the cell") }
        
        let car = Cars[indexPath.row]
        if let oldResults = oldResults {
            /*
             the old results have black color, the new ones red
             */
            if checkNewResult(oldResults, newCar: car) {
                cell.textLabel?.textColor = .black
            } else {
                cell.textLabel?.textColor = .red
            }
        } else {
            cell.textLabel?.textColor = .red
        }
        
        cell.textLabel?.text = car.title
        cell.textLabel?.font = cell.textLabel?.font.withSize(12)
        cell.detailTextLabel?.text = "phone number - \(car.phoneNumber)   price - \(car.price)$"
        
        return cell
    }
    
    //MARK: Parsing the data
    private func parseData() {
        /*
         this function parses data from the autotrade.com , adds loading view while the app is parsing
         the data and removes it when the parsing is done.
         */
        
        
        let loadView = createLoadView()
        
        // making the parsing
        parse(loadView: loadView)
                
    }
    
    private func createLoadView() -> UIView {
        /*
         creates loadview and adds to main view
         @return loadview
         */
        
        // making the load view
        let loadView = UIView()
        let label = UILabel(frame: CGRect(x: 30, y: 55, width: 70, height: 20))
        label.text = "Parsing"
        label.textColor = .systemGray
        
        
        loadView.frame = CGRect(x: (self.view.bounds.width / 2) - 60, y: (self.view.frame.height / 2) - 30, width: 120, height: 80)
        loadView.backgroundColor = .systemGray6
        loadView.layer.cornerRadius = 10
        
        let spiner = SpinnerView(frame: CGRect(x: 40, y: 10, width: 40, height: 40)) // custom spinner
        
        loadView.addSubview(spiner)
        loadView.addSubview(label)
        self.view.addSubview(loadView)
        
        return loadView
    }
    
    private func parse(loadView: UIView?) {
        // making the parameters for each page
        let params = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, time: 180, page: 0)
        let params1 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, time: 180, page: 1)
        let params2 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, time: 180, page: 2)
        let params3 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, time: 180, page: 3)
        let params4 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, time: 180, page: 4)
        
        
        let parser = Parser(params: params)
        parser.parseData { [weak self] result in
            var cars = [Car]()
            switch result {
            case .success(let parsedCars):
                cars += parsedCars
                
                // page 1
                let parser1 = Parser(params: params1)
                parser1.parseData { [weak self] result in
                    switch result {
                    case .success(let parsedCars1):
                        cars += parsedCars1
                        
                        // page 2
                        let parser2 = Parser(params: params2)
                        parser2.parseData { [weak self] result in
                            switch result {
                            case .success(let parsedCars2):
                                cars += parsedCars2

                                // page 3
                                let parser3 = Parser(params: params3)
                                parser3.parseData { [weak self] result in
                                    switch result {
                                    case .success(let parsedCars3):
                                        cars += parsedCars3

                                        // page 4
                                        let parser4 = Parser(params: params4)
                                        parser4.parseData { [weak self] result in
                                            
                                            switch result {
                                            case .success(let parsedCars4):
                                                cars += parsedCars4
                                                self?.Cars = cars
                                                /*
                                                 saving the data, if it has old values , the oldResults will get them
                                                 */
                                                self?.oldResults = self?.dataManager?.saveDataToContainer(cars: self!.Cars)
                                                
                                                // removing loading view from superview when the parsing is done
                                                loadView?.removeFromSuperview()
                                                
                                                let ac = UIAlertController(title: "Success", message: "Data has parsed successfuly", preferredStyle: .alert)
                                                ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                                                
                                                
                                                self?.present(ac, animated: true)
                                                self?.tableView.reloadData()
                                                
                                                self?.timer = Timer.scheduledTimer(timeInterval: TimeInterval(10), target: self, selector: #selector(self?.parseAgain), userInfo: nil, repeats: false)
                                            case.failure(let error):
                                                print(error.localizedDescription)
                                                loadView?.removeFromSuperview()
                                                
                                                // showning alert controller if the loading fails
                                                self?.showFailAlert()
                                            }
                                            // saving the data if it is changed
                                            self?.dataManager?.saveContext()
                                        }
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                        loadView?.removeFromSuperview()
                                        
                                        // showning alert controller if the loading fails
                                        self?.showFailAlert()
                                    }
                                    
                                }
                            case .failure(let error):
                                print(error.localizedDescription)
                                loadView?.removeFromSuperview()
                                
                                // showning alert controller if the loading fails
                                self?.showFailAlert()
                            }
                            
                            
                        }
                        
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        loadView?.removeFromSuperview()
                        
                        // showning alert controller if the loading fails
                        self?.showFailAlert()
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                loadView?.removeFromSuperview()
                
                // showning alert controller if the loading fails
                self?.showFailAlert()
            }
            
            
        }
    }
    
    private func checkNewResult(_ oldCars: [Car], newCar: Car) -> Bool {
        for car in oldCars {
            if (car.phoneNumber == newCar.phoneNumber) && (car.price == car.price) && (car.title == car.title) {
                return true
            }
        }
        
        return false
    }
    
    private func showFailAlert() {
        /*
         shows alert when the parsing fails
         */
        
        let ac = UIAlertController(title: "Couldn't load the data", message: "Please check your internet conncetion", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(ac, animated: true)
    }
    
    private func setupNavBar() {
        /*
         makes the navigation bar buttons
         */
        
        let rightBarButtonItem = UIBarButtonItem(title: "Scrap time", style: .plain, target: self, action: #selector(setTimer))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func parseAgain() {
        print("starting parsing")
        parse(loadView: nil)
        print("parsed again")
    }
    
    @objc func setTimer() {
        /*
        sets the rescraping timers time
         */
        let ac = UIAlertController(title: "parsing time", message: "Choose parsing time", preferredStyle: .actionSheet)
        for i in 2...10 {
            let time = i * 60
            let action = UIAlertAction(title: "\(time)", style: .default) { (action) in
                UtilsGeneral.rescrapingTime = time
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.regisetLocal()
                appDelegate?.scheduleLocal(title: "Du shat la txa es", phoneNumber: "099838882", price: "123")
                
            }
            ac.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    //MARK: UNNotificationCenterDelegate methods
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([UNNotificationPresentationOptions.banner, .badge, .sound])
    }
    

    
}
