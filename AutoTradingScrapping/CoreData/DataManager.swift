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
    private var parameters: SearchParams? = nil
    
    init() {
        /*
         makes the NSPersistentContainer
         */
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
    }
    
    func setParams(params: SearchParams) {
        self.parameters = params
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
        guard let params = parameters else { return }
        
        searchData.brand = params.brand
        searchData.model = params.model
        searchData.zipCode = params.zipCode
        searchData.startYear = params.startYear
        searchData.endYear = params.endYear
        searchData.result = carsData
        
        print("this is count \(searchData.result?.count)")
        
    }
    
    func deleteData(_ object: SearchData) {
        container.viewContext.delete(object)
    }
    
    func loadSavedData() -> [SearchData] {
        /*
         loads the data from Core Data NSPersistentStore
         @return array of
         */
        var searchDatas = [SearchData]()
        
        let request: NSFetchRequest<SearchData> = SearchData.fetchRequest()
        let sort = NSSortDescriptor(key: "brand", ascending: true)
        
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
            guard let params = parameters else { return }

            
            if (model.brand == params.brand) &&
                (model.model == params.model) &&
                (model.zipCode == params.zipCode) &&
                (model.startYear == params.startYear) &&
                (model.endYear == params.endYear) {
                model.result = NSSet(array: carsData) // update result if search has already done before
                return
            }
        }
        
        let searchData = SearchData(context: (self.container.viewContext))
        
        
        self.configure(searchData: searchData, carsData: NSSet(array: carsData))

    }
}
