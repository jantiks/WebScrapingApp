//
//  StartVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit
import CoreData
import WebKit

class StartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var addButton: UIButton!
    
    // instance variables
    public static var container: NSPersistentContainer!
    private var SearchDatas = [SearchData]()
    private var Cars = [CarsData]()
    private var dataManager: DataManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setting tableView delegate and data source
        tableView.delegate = self
        tableView.dataSource = self
        
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
        return SearchDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         returnes specific cell for each tableview row
         */
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError("couldn't load tableview cell") }
        cell.configureCellUI()
        cell.textLabel?.text = SearchDatas[indexPath.row].brand
        cell.detailTextLabel?.text = "\(SearchDatas[indexPath.row].model)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         when user taps on tableview row , viewcontroller oppens the ResultsVC
         */
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UtilsGeneral.SBID_ResultsVC) as? ResultsVC else { return }
        vc.brandValue = SearchDatas[indexPath.row].brand
        vc.modelValue = SearchDatas[indexPath.row].model
        vc.zipCode = SearchDatas[indexPath.row].zipCode
        
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
            dataManager?.deleteData(SearchDatas[indexPath.row])
            SearchDatas.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic) // deleting row
            
            dataManager?.saveContext() // saving changes
            
            
        }
    }
    
    // MARK: IBActions
    @IBAction private func addButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UtilsGeneral.SBID_BrandsVC) as? BrandsVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: CoreData
    
    private func loadCarsData() {
        dataManager = DataManager()
        SearchDatas = dataManager?.loadSavedData() ?? [SearchData]()
        
        tableView.reloadData()
    }
    
    
}
