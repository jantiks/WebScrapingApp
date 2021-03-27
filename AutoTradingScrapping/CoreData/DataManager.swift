//
//  DataManager.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/27/21.
//

import Foundation
import CoreData

class DataManager {
    private var container: NSPersistentContainer!
    private var parameters: SearchParams
    
    init(params: SearchParams) {
        /*
         makes the NSPersistentContainer
         */
        self.parameters = params
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    
    func saveContext() {
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
    
    private func configure(searchData: SearchData, carsData: NSSet) {
        /*
         this function saves the data to CoreData model
         */
        // saving the search data
        searchData.brand = parameters.brand
        searchData.model = parameters.model
        searchData.zipCode = parameters.zipCode
        searchData.result = carsData
        print("this is count \(searchData.result?.count)")
        
    }
    
    private func loadSavedData() -> [SearchData] {
        /*
         loads the data from Core Data NSPersistentStore
         @return array of
         */
        var searchDatas = [SearchData]()
        
        let request: NSFetchRequest<SearchData> = SearchData.fetchRequest()
        let sort = NSSortDescriptor(key: "brand", ascending: false)
        
        request.sortDescriptors = [sort]
        
        
        do {
            searchDatas = try container.viewContext.fetch(request)
            
        } catch  {
            print("error")
        }
        
        return searchDatas

    }
    
    func saveDataToContainer(cars: [Car]) {
        /*
         checks if existing database has the values , if not the method saves them
         */
        var carsData = [CarsData]()
        let searchDatas = loadSavedData()
        
        // saving the Search reuslt
        var carsPos:Int16 = 0
        for car in cars {
            let carData = CarsData(context: self.container.viewContext)
            carData.phoneNumber = car.phoneNumber
            carData.price = car.price
            carData.title = car.title
            carData.position = carsPos
            carsData.append(carData)
            
            carsPos += 1
        }
            
        
        for model in searchDatas {
            /*
             checking if data already exists then return
             */
            
            if (model.brand == parameters.brand) && (model.model == parameters.model) && (model.zipCode == parameters.zipCode) {
                model.result = NSSet(array: carsData) // update result if search has already done before
                return
            }
        }
        
        let searchData = SearchData(context: (self.container.viewContext))
        
        
        self.configure(searchData: searchData, carsData: NSSet(array: carsData))

    }
}
