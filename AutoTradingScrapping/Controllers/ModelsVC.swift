//
//  ModelsVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit

class ModelsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // instance variables
    var models = [String:String]()
    var brandValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: UITabelViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
          returns the number of rows in tableview section
         */
        
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         returnes specific cell for each tableview row
         */
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError("couldn't load the cell") }
        let keys = Array(models.keys).sorted() // getting keys of models dictionary
        
        cell.textLabel?.text = keys[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         when user taps on tableview row , viewcontroller oppens the ResultsVC
         */
        let cell = tableView.cellForRow(at: indexPath)
        guard let modelValue = cell?.textLabel?.text else { return }
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UtilsGeneral.SBID_ResultsVC) as? ResultsVC else { return }
        vc.brandValue = brandValue
        print("this is \(modelValue)")
        vc.modelValue = modelValue
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
}
