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
    private let resourceURL: URL

    init(brand: String, model: String, zipCode: String, startYear: String, endYear: String) {
        
        let resourceString = "https://www.autotrader.com/cars-for-sale/all-cars/\(brand)/\(model)/new-york-ny-\(zipCode)?dma=&searchRadius=100&location=&startYear=\(startYear)&marketExtension=include&endYear=\(endYear)&isNewSearch=false&showAccelerateBanner=false&sortBy=relevance&numRecords=100"
        
            
        // website addres
        guard let resourceURL = URL(string: resourceString) else { fatalError(resourceString) }
        
        self.resourceURL = resourceURL
        
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
