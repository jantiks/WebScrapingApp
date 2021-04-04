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
        
        title = "Choose Model"
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
        let ac = UIAlertController(title: "Years range", message: "pecify the years range", preferredStyle: .alert)
        
        // adding textfields to UIAlretController
       
        ac.addTextField { (textField) in
            textField.placeholder = "Start Year"
        }
        ac.addTextField { (textField) in
            textField.placeholder = "End Year"
        }
        
        // setting the keyboard typeto textfields
        
        guard let textFields = ac.textFields else { return }
        for field in textFields {
            field.keyboardType = .numberPad
        }
        
        // submit action
        let submit = UIAlertAction(title: "Submit", style: .default) { [unowned self] (action) in
            
            // getting the values of textfields
            guard let startYear = ac.textFields![0].text else { return }
            guard let endYear = ac.textFields![1].text else { return }

            let cell = tableView.cellForRow(at: indexPath)
            guard let modelValue = cell?.textLabel?.text else { return }
            
            // ResultsVC
            guard let vc = storyboard?.instantiateViewController(withIdentifier: UtilsGeneral.SBID_ResultsVC) as? ResultsVC else { return }
            vc.brandValue = brandValue
            vc.modelValue = getModelValue(value: modelValue)
            vc.zipCode = "10001" // can be modified in future
            vc.startYear = startYear
            vc.endYear = endYear
                        
            navigationController?.pushViewController(vc, animated: true)
        }
        
        // cancel action
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(submit)
        ac.addAction(cancel)
        
        present(ac, animated: true)
        
    }
    
    private func getModelValue(value: String) -> String {
        /*
         value: the brand name or model name of car
         this method returnes configured value
         */
        
        var newValue = value
        if newValue.starts(with: "- ") {
            print(newValue)
            newValue.removeFirst()
            newValue.removeFirst()
        }
        
        newValue = newValue.replacingOccurrences(of: " ", with: "-")
        
        return newValue
    }
    

    
}
