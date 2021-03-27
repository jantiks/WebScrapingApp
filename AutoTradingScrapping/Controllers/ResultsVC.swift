//
//  ResultsVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit
import CoreData
import WebKit

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    // instance variables
    private var container: NSPersistentContainer!
    
    var brandValue = ""
    var modelValue = ""
    var zipCode = ""
    var startYear = ""
    var endYear = ""
    
        
    private var Cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Core Data Containter
        makeContainer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func loadView() {
        super.loadView()
        makeContainer()
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
        
        cell.textLabel?.text = car.title
        cell.textLabel?.font = cell.textLabel?.font.withSize(12)
        cell.detailTextLabel?.text = "phone number - \(car.phoneNumber)   price - \(car.price)$"
        
        return cell
    }
    
    //MARK: Core Data
    
    private func makeContainer() {
        /*
         makes the NSPersistentContainer
         */
        
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    
    private func saveContext() {
        /*
         this function saves the data to the disk
         */
        
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch  {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    
    private func configure(searchData: SearchData, carsData: NSSet) {
        /*
         this function saves the data to CoreData model
         */
        // saving the search data
        searchData.brand = brandValue
        searchData.model = modelValue
        searchData.zipCode = zipCode
        searchData.result = carsData
        print("this is count \(searchData.result?.count)")
        
    }
    
    private func loadSavedData() -> [SearchData] {
        /*
         loads the data from Core Data NSPersistentStore
         @return array of
         */
        var searchDatas = [SearchData]()
        
        let request: NSFetchRequest<SearchData> = SearchData.fetchRequest()
        let sort = NSSortDescriptor(key: "brand", ascending: false)
        
        request.sortDescriptors = [sort]
        
        
        do {
            searchDatas = try container.viewContext.fetch(request)
            
        } catch  {
            print("error")
        }
        
        return searchDatas

    }
    
    private func saveDataToContainer() {
        /*
         checks if existing database has the values , if not the method saves them
         */
        var carsData = [CarsData]()
        let searchDatas = loadSavedData()
        
        // saving the Search reuslt
        var carsPos:Int16 = 0
        for car in Cars {
            let carData = CarsData(context: self.container.viewContext)
            carData.phoneNumber = car.phoneNumber
            carData.price = car.price
            carData.title = car.title
            carData.position = carsPos
            carsData.append(carData)
            
            carsPos += 1
        }
            
        
        for model in searchDatas {
            /*
             checking if data already exists then return
             */
            
            if (model.brand == brandValue) && (model.model == modelValue) && (model.zipCode == zipCode) {
                model.result = NSSet(array: carsData) // update result if search has already done before
                return
            }
        }
        
        let searchData = SearchData(context: (self.container.viewContext))
        
        
        self.configure(searchData: searchData, carsData: NSSet(array: carsData))

    }
    
    //MARK: Parsing the data
    private func parseData() {
        /*
         this function parses data from the autotrade.com , adds loading view while the app is parsing
         the data and removes it when the parsing is done.
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
        
    
        
            // making the parameters for each page
            let params = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, page: 0)
            let params1 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, page: 1)
            let params2 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, page: 2)
            let params3 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, page: 3)
            let params4 = SearchParams(brand: brandValue, model: modelValue, zipCode: zipCode, startYear: startYear, endYear: endYear, page: 4)
    
        
            let parser = Parser(params: params)
            parser.parseData { [weak self] result in
                switch result {
                case .success(let parsedCars):
                    self?.Cars += parsedCars
                    
                    // page 1
                    let parser1 = Parser(params: params1)
                    parser1.parseData { [weak self] result in
                        switch result {
                        case .success(let parsedCars1):
                            self?.Cars += parsedCars1
                            
                            // page 2
                            let parser2 = Parser(params: params2)
                            parser2.parseData { [weak self] result in
                                switch result {
                                case .success(let parsedCars2):
                                    self?.Cars += parsedCars2
                                    
                                    // page 3
                                    let parser3 = Parser(params: params3)
                                    parser3.parseData { [weak self] result in
                                        switch result {
                                        case .success(let parsedCars3):
                                            self?.Cars += parsedCars3
                                            
                                            // page 4
                                            let parser4 = Parser(params: params4)
                                            parser4.parseData { [weak self] result in
                                                switch result {
                                                case .success(let parsedCars4):
                                                    self?.Cars += parsedCars4
                                                    
                                                    // saving the data
                                                    self?.saveDataToContainer()
                                                    
                                                    // removing loading view from superview when the parsing is done
                                                    loadView.removeFromSuperview()
                                                    
                                                    let ac = UIAlertController(title: "Success", message: "Data has parsed successfuly", preferredStyle: .alert)
                                                    ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                                                    
                                                    self?.present(ac, animated: true)
                                                    
                                                    self?.tableView.reloadData()
                                                case.failure(let error):
                                                    print(error.localizedDescription)
                                                    loadView.removeFromSuperview()
                                                    
                                                    // showning alert controller if the loading fails
                                                    self?.showFailAlert()
                                                }
                                                // saving the data if it is changed
                                                self?.saveContext()
                                            }
                                        case .failure(let error):
                                            print(error.localizedDescription)
                                            loadView.removeFromSuperview()
                                            
                                            // showning alert controller if the loading fails
                                            self?.showFailAlert()
                                        }
                                        
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                    loadView.removeFromSuperview()
                                    
                                    // showning alert controller if the loading fails
                                    self?.showFailAlert()
                                }
                                
                                
                            }
                            
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                            loadView.removeFromSuperview()
                            
                            // showning alert controller if the loading fails
                            self?.showFailAlert()
                        }
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    loadView.removeFromSuperview()
                    
                    // showning alert controller if the loading fails
                    self?.showFailAlert()
                }
                
                
            }
                
    }
    
    private func showFailAlert() {
        /*
         shows alert when the parsing fails
         */
        
        let ac = UIAlertController(title: "Couldn't load the data", message: "Please check your internet conncetion", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        self.present(ac, animated: true)
    }
    

    
}
