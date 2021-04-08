//
//  CarsData+CoreDataProperties.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/27/21.
//
//

import Foundation
import CoreData


extension CarsData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarsData> {
        return NSFetchRequest<CarsData>(entityName: "CarsData")
    }

    @NSManaged public var phoneNumber: String
    @NSManaged public var price: String
    @NSManaged public var title: String
    @NSManaged public var position: Int16


    @NSManaged public var searchData: SearchData?

}

extension CarsData : Identifiable {

}
