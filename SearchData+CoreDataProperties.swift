//
//  CarData+CoreDataProperties.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/14/21.
//
//

import Foundation
import CoreData


extension SearchData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchData> {
        return NSFetchRequest<SearchData>(entityName: "SearchData")
    }

    @NSManaged public var brand: String
    @NSManaged public var model: String
    @NSManaged public var zipCode: String


}

extension SearchData : Identifiable {

}
