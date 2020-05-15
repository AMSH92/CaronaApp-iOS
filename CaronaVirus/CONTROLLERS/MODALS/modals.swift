//
//  modals.swift
//  CaronaVirus
//
//  Created by Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.
//

import Foundation
import UIKit


struct Country {
    let country: Countries?
    let gradientColors : [UIColor]?
}

class HandleData {
    var object: Feed?
    
    fileprivate var gulfCountries = ["SA","AE","KW","QA","BH","OM","IQ"]
    fileprivate var countryFiltering = [Countries]()
    var colors = [UIColor]()

    func sortGulf() -> [Countries] {
        
        self.gulfCountries.forEach({ c in
            let country = self.object?.response?.Countries?.filter({$0.CountryCode == c}).first
            countryFiltering.append(country!)
            if c == "SA" {
                colors.append(UIColor.flatGreenColorDark())
            }
            colors.append(UIColor.flatRed())
        })
        return countryFiltering
    }
    
    func sortAllCountries() -> [Countries] {
        return self.object?.response?.Countries ?? []
    }
    
    func sortGlobal() -> Global? {
        return self.object?.response?.Global
    }
    
    func searchGlobal(searchText: String) -> [Countries] {
        print(searchText)
        return (self.object?.response?.Countries?.filter({($0.Country?.localizedCaseInsensitiveContains(searchText))!}))!
    }
}
