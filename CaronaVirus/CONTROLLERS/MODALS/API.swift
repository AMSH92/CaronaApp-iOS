//
//  API.swift
//  CaronaVirus
//
//  Created by Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.
//

import Foundation
import UIKit

struct Response: Decodable {
    let Global: Global?
    var Countries: [Countries]?
}

struct Global: Decodable {
    let NewConfirmed: Int?
    let TotalConfirmed: Int?
    let TotalRecovered: Int?
    let NewDeaths: Int?
    let TotalDeaths: Int?
    let NewRecovered: Int?
}

struct Countries: Decodable {
    let Country: String?
    let CountryCode: String?
    let Slug: String?
    let NewConfirmed: Int?
    let TotalConfirmed: Int?
    let NewDeaths: Int?
    let TotalDeaths: Int?
    let NewRecovered: Int?
    let TotalRecovered: Int?
    let Date: String?
}

class API {
    
    typealias didFetchSuccess = (Response)->()
    typealias didFailWithError = (Error?)->()
    
    fileprivate var baseURL = "https://api.covid19api.com/summary"

    func getCases(withSuccess: @escaping didFetchSuccess, withError:  @escaping didFailWithError) {
        
        guard let url = URL(string: baseURL) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]

        URLSession.shared.dataTask(with: request) { (data, resp, err) in
            if let err = err {
                withError(err)
                return
            }
            do {
                let results = try JSONDecoder().decode(Response.self, from: data!)
                withSuccess(results)
            } catch let err {
                withError(err)
            }
        }.resume()
    }
}
