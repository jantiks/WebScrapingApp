//
//  Parser.swift
//  AutoTradingScrapping
//
//  Created by Tigran on 3/10/21.
//

import Foundation
import SwiftSoup
import Erik

class Parser {
    
    func parseData() {
        
        let UrlString = "https://www.autotrader.com/cars-for-sale/all-cars/toyota/camry/dublin-oh-43016?lastExec=2021-03-11T13%3A59%3A23.898Z&dma=&searchRadius=500&location=&marketExtension=include&isNewSearch=false&showAccelerateBanner=false&sortBy=relevance&numRecords=100" // website addres
        guard let Url = URL(string: UrlString) else { return } // url
        
        Erik.visit(url: Url) { (doc, error) in
            /*
             doc: web page
             error: error
             headless browser opens the web page
             */
            do {
                
                guard let innerHTML = doc?.innerHTML else { return } // making string from html
                let htmlBody = try SwiftSoup.parse((innerHTML)) // parsing html string
                let cardElements = try htmlBody.getElementsByClass("item-card-content") //
                
                
                print("this is title elements \(cardElements.array())")
                var count = 0
                for element in cardElements {
                    
                    count += 1
                    print("the count is \(count)")
                    print(element)
                }
            } catch  {
                print(error.localizedDescription)
            }
        }
        
    }
}
