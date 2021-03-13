//
//  BrandsVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit

class BrandsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    let brands = UtilsGeneral.brands
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Choose Brand"
    }
    
    // MARK: UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
          returns the number of rows in tableview section
         */
        
        brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
         returnes specific cell for each tableview row
         */
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { fatalError("Couldn't load cell") }
        
        cell.textLabel?.text = brands[indexPath.row]["label"] as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*
         when user taps on tableview row , viewcontroller oppens the ModelsVC
         */
        
        let models = brands[indexPath.row]["models"] as! [String : String]
        let brandValue = brands[indexPath.row]["value"] as! String
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: UtilsGeneral.SBID_ModelsVC) as? ModelsVC else { return }
        
        vc.models = models
        vc.brandValue = brandValue
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
