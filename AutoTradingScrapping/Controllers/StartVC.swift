//
//  StartVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit
import CoreData

class StartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    
    // instance variables
    private var container: NSPersistentContainer!
    private var Cars = [SearchData]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
        // parsing the data
        var parser = Parser(brand: "Toyota", model: "Camry")
        parser.makeBrands()

        
        setupUI()
        loadCarsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadCarsData()
    }
    
    private func setupUI() {
        /*
         setups ui for viewDidLoad method
         */
        addButton.layer.cornerRadius = addButton.bounds.size.width / 2
        tableView.configureTableViewUI()
    }
    
    
    // MARK: UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
          returns the number of rows in tableview section
         */
        return Cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         returnes specific cell for each tableview row
         */
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError("couldn't load tableview cell") }
        cell.configureCellUI()
        cell.textLabel?.text = Cars[indexPath.row].brand
        cell.detailTextLabel?.text = Cars[indexPath.row].model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         when user taps on tableview row , viewcontroller oppens the ResultsVC
         */
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UtilsGeneral.SBID_ResultsVC) as? ResultsVC else { return }
        vc.brandValue = Cars[indexPath.row].brand
        vc.modelValue = Cars[indexPath.row].model
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        /*
         deletes the row from table view
         */
        
        if editingStyle == .delete {
            
            // deleting the data from Core Data store
            container.viewContext.delete(Cars[indexPath.row])
            Cars.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic) // deleting row
            
            saveContext() // saving changes 
            
            
        }
    }
    
    // MARK: IBActions
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UtilsGeneral.SBID_BrandsVC) as? BrandsVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: CoreData
    
    private func loadCarsData() {
        makeContainer()
        loadSavedData()
        
        tableView.reloadData()
    }
    
    private func makeContainer() {
        /*
         makes the NSPersistentContainer
         */
        
        container = NSPersistentContainer(name: "Model")
        container?.loadPersistentStores { storeDescription, error in
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
    
    private func loadSavedData() {
        /*
         loads the data from Core Data NSPersistentStore
         */
        
        let request: NSFetchRequest<SearchData> = SearchData.fetchRequest()
        let sort = NSSortDescriptor(key: "brand", ascending: true)
        
        request.sortDescriptors = [sort]
        
        do {
            Cars = try container.viewContext.fetch(request)
            print("got \(Cars.count) datas")
        } catch  {
            print("error")
        }
        

    }
    
    
    
}
