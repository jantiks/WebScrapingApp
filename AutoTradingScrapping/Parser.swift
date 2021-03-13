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

    init(brand: String, model: String) {
        
        let resourceString = "https://www.autotrader.com/cars-for-sale/all-cars/ACURA/INTEG/dublin-oh-43016?lastExec=2021-03-11T13%3A59%3A23.898Z&dma=&searchRadius=500&location=&marketExtension=include&isNewSearch=false&showAccelerateBanner=false&sortBy=relevance&numRecords=100" // website addres
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
        
    }
    
    func makeBrands() {
        let html = "<option value=\"PHANT\">Phantom</option><option value=\"WRAI\">Wraith</option><option value=\"GHOST\">Ghost</option><option value=\"RRCULLINAN\">Cullinan</option>"
        do {
            let innerHtml = try SwiftSoup.parse(html)
            var justArray = try innerHtml.select("option").array()
            var titleArray = [String]()
            for elem in justArray {
                titleArray.append(try elem.text())
            }
            let arrays = html.components(separatedBy: "option value=")
            var valueArray = [String]()
            for elem in arrays {
                let text = elem.components(separatedBy: ">")[0].replacingOccurrences(of: "\"", with: "")
                if text == "<" {
                    continue
                } else {
                    valueArray.append(text)
                }
            }
//            let newtitleArray = titleArray.components(separatedBy: " ")

            var dict = [String:String]()
            for i in 0..<titleArray.count {
                dict[titleArray[i]] = valueArray[i]
            }
            print(dict)
        } catch {
            print(error)
        }
        
    }
    
    func parseData(completion: @escaping(Result<[Car], Error>) -> Void){
        var Cars = [Car]()

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
                    var phoneNumber = "" // phone number
                    for elem in footer {
                        phoneNumber = try elem.getElementsByClass("display-block").select("span").first()?.text() as! String
                    }
                    
                    // getting price
                    let price = try element.getElementsByClass("first-price").text()
                    if phoneNumber.isEmpty {
                        continue
                    } else {
                        let car = Car(title: title, price: price, phoneNumber: phoneNumber)
                        Cars.append(car)
                    }
                    
                }
                completion(.success(Cars))
                
            } catch  {
                completion(.failure(error))
            }

        }
    }
    
}
