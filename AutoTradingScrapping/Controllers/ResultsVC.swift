//
//  ResultsVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit
import CoreData

class ResultsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    // instance variables
    private var container: NSPersistentContainer!
    
    var brandValue = ""
    var modelValue = ""
    var zipCode = ""
    var startYear = ""
    var endYear = ""
    
    private var parser: Parser? = nil
    
    private var Cars = [Car]()
    private var SearchDatas = [SearchData]()
    
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
        parseData()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        parser = nil
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
    
    private func configure(searchData: SearchData) {
        /*
         this function saves the data to CoreData model
         */
        searchData.brand = brandValue
        searchData.model = modelValue
        searchData.zipCode = zipCode
    }
    
    private func loadSavedData() {
        /*
         loads the data from Core Data NSPersistentStore
         */
        
        let request: NSFetchRequest<SearchData> = SearchData.fetchRequest()
        let sort = NSSortDescriptor(key: "brand", ascending: false)
        
        request.sortDescriptors = [sort]
        
        do {
            SearchDatas = try container.viewContext.fetch(request)
            print("got \(SearchDatas.count) datas")
        } catch  {
            print("error")
        }
        

    }
    
    private func saveDataToContainer() {
        /*
         checks if existing database has the values , if not the method saves them
         */
        
        loadSavedData()
        
        
        for model in SearchDatas {
            /*
             checking if data already exists then return
             */
            if (model.brand == brandValue) && (model.model == modelValue) && (model.zipCode == zipCode) {
                return
            }
        }
        
        let searchData = SearchData(context: (self.container.viewContext))
        self.configure(searchData: searchData)

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
        
        // parsing the data
        let brand = getBrandValue(value: self.brandValue).lowercased()
        let model = getBrandValue(value: self.modelValue).lowercased()
        
        
        parser = Parser(brand: brand, model: model, zipCode: zipCode, startYear: startYear, endYear: endYear)
        parser?.parseData { [weak self] result in
            
            switch result {
            case .success(let Cars):
                self?.Cars = Cars
                
                // saving data to Core Data model if it hasn't dublicate in existing database
                self?.saveDataToContainer()
                
                // removing loading view from superview when the parsing is done
                loadView.removeFromSuperview()
                
                let ac = UIAlertController(title: "Success", message: "Data has parsed successfuly", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                
                self?.present(ac, animated: true)
                
                self?.tableView.reloadData()
                
            case .failure(let error):
                
                print(error.localizedDescription)
                loadView.removeFromSuperview()
                
                // showning alert controller if the loading fails
                let ac = UIAlertController(title: "Couldn't load the data", message: "Please check your internet conncetion", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                
                self?.present(ac, animated: true)
            }
            
            // saving the data if it is changed
            self?.saveContext()
        }
    }
    
    private func getBrandValue(value: String) -> String {
        /*
         value: the brand name or model name of car
         this method returnes configured value
         */
        
        var newValue = value
        if newValue.starts(with: "- ") {
            newValue.removeFirst()
            newValue.removeFirst()
        }
        
        newValue = newValue.replacingOccurrences(of: " ", with: "-")
        
        return newValue
    }

    
}
