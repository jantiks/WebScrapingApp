//
//  Parser.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import Foundation
import SwiftSoup
import Erik

struct Parser {
    private var resourceURLStr = ""

    init(params: SearchParams) {
        // website addres
        self.resourceURLStr = getResourceString(params)
        
    }
    
    private func getResourceString(_ params: SearchParams) -> String {
        var resourceStr = ""
        
        if params.page == 0 {
            resourceStr = "https://www.autotrader.com/cars-for-sale/all-cars/\(params.brand)/\(params.model)/new-york-ny-\(params.zipCode)?dma=&searchRadius=25&isNewSearch=false&marketExtension=include&showAccelerateBanner=false&sortBy=relevance&numRecords=100"
        } else if params.page > 0 {
            resourceStr = "https://www.autotrader.com/cars-for-sale/all-cars/\(params.brand)/\(params.model)/new-york-ny-\(params.zipCode)?dma=&searchRadius=25&isNewSearch=false&marketExtension=include&showAccelerateBanner=false&sortBy=relevance&numRecords=100&firstRecord=\(100 * params.page)"
        }
        
        if !(params.startYear.isEmpty) {
            resourceStr += "&startYear=\(params.startYear)"
        }
        
        if !(params.endYear.isEmpty) {
            resourceStr += "&endYear=\(params.endYear)"
        }
            
        return resourceStr
    }
    
    func parseData(completion: @escaping(Result<[Car], Error>) -> Void){
        var Cars = [Car]()

        // timeout timer
        let timer: Timer
        var count = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            timer.tolerance = 1
            count += 1
            print(count)
            
            if count == 30 {
                timer.invalidate()
                
                completion(.failure(NSError(domain: "TimeOut", code: 69, userInfo: nil)))
            }
        }
        
        // making the url
        guard let resourceURL = URL(string: resourceURLStr) else { return }
        Erik.visit(url: resourceURL) { (doc, error) in
            /*
             doc: web page
             error: error
             headless browser opens the web page and loads the html
            */
            
            
            do {
                guard let innerHTML = doc?.innerHTML else { return } // making string from html
                let htmlBody = try SwiftSoup.parse((innerHTML)) // parsing html string
                let cardElements = try htmlBody.getElementsByClass("item-card-content") // getting all html from car listing
                
                // getting title , phone number , price from html
                for element in cardElements {
                    // getting title
                    let title = try element.getElementsByTag("h2").text()
                    
                    // getting the phone number
                    let footer = try element.getElementsByClass("listing-footer")
                    for elem in footer {
                        if let phoneNumber = try elem.getElementsByClass("display-block").select("span").first()?.text() {
                            // getting price
                            let price = try element.getElementsByClass("first-price").text()
                            if phoneNumber.isEmpty {
                                continue
                            } else {
                                let car = Car(title: title, price: price, phoneNumber: phoneNumber)
                                Cars.append(car)
                            }
                        }
                    }
                }
                timer.invalidate()
                completion(.success(Cars))
                
            } catch  {
                timer.invalidate()
                completion(.failure(error))
            }

        }
    }
    
}
