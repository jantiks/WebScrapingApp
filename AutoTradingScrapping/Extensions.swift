//
//  Extensions.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import Foundation
import UIKit


// table view
extension UITableView {
    func configureTableViewUI() {
        self.separatorStyle = .none
    }
}

// table view cell
extension UITableViewCell {
    func configureCellUI() {
        self.selectedBackgroundView?.backgroundColor = .systemBlue
    }
}
