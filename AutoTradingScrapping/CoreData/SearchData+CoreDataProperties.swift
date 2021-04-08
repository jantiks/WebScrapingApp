//
//  SearchData+CoreDataProperties.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/27/21.
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
    @NSManaged public var startYear: String
    @NSManaged public var endYear: String
    @NSManaged public var timer: Int16

    @NSManaged public var result: NSSet?

}

// MARK: Generated accessors for cars
extension SearchData {

    @objc(addCarsObject:)
    @NSManaged public func addToCars(_ value: CarsData)

    @objc(removeCarsObject:)
    @NSManaged public func removeFromCars(_ value: CarsData)

    @objc(addCars:)
    @NSManaged public func addToCars(_ values: NSSet)

    @objc(removeCars:)
    @NSManaged public func removeFromCars(_ values: NSSet)

}

extension SearchData : Identifiable {

}
