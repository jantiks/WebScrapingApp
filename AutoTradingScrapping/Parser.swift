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
                let cardElements = try htmlBody.getElementsByClass("item-card-content") // getting all html from car listing
                
                // getting title , phone number , price from html
                for element in cardElements {
                    let title = try element.getElementsByTag("h2").text() // the title
                    let phoneNumber = self.getPhoneNumber(element)
                    let price = try element.getElementsByClass("first-price").text()
                    
                    
                    
                }
            } catch  {
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func getPhoneNumber(_ element: SwiftSoup.Element) -> String {
        /*
         returnes phone number
         */
        
        var phoneNumber = ""
        do {
            let footer = try element.getElementsByClass("listing-footer")
            for elem in footer {
                phoneNumber = try elem.getElementsByClass("display-block").select("span").first()?.text() as! String
            }
            
        } catch {
            print("Couldn't load phone number")
        }
        return phoneNumber
    }
    
    private func getPrice(_ element: SwiftSoup.Element) -> String {
        /*
         returnes the price of car from html
         */
        var price = ""
        return price
    }
}
