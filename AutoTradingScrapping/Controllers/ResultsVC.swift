//
//  ResultsVC.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import UIKit

class ResultsVC: UIViewController {

    // instance variables
    var brandValue = ""
    var modelValue = ""
    private var Cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func loadView() {
        super.loadView()
        parseData()

    }
    
    private func parseData() {
        
        // making the load view
        let loadView = UIView()
        let label = UILabel(frame: CGRect(x: 30, y: 55, width: 70, height: 20))
        label.text = "Parsing"
        label.textColor = .systemGray
        
        
        loadView.frame = CGRect(x: (self.view.bounds.width / 2) - 60, y: (self.view.frame.height / 2) - 30, width: 120, height: 80)
        loadView.backgroundColor = .white
        loadView.layer.cornerRadius = 10
        
        let spiner = SpinnerView(frame: CGRect(x: 40, y: 10, width: 40, height: 40)) // custom spinner
        
        loadView.addSubview(spiner)
        loadView.addSubview(label)
        self.view.addSubview(loadView)
        
        // parsing the data
        
        let parser = Parser(brand: self.brandValue, model: self.modelValue)
        parser.parseData { [weak self] result in
            switch result {
            case .success(let Cars):
                self?.Cars = Cars
                loadView.removeFromSuperview()
                print(self?.Cars)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
}
