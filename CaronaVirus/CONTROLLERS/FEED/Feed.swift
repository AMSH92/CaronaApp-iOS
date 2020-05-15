//
//  Feed.swift
//  CaronaVirus
//
//  Created Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.

import UIKit
/// Feed Model
struct  Feed {
    typealias didFetchSuccess = (Feed)->()
    typealias didFailWithError = (Error?) -> ()
    
    // Your Model Structure
    
    var response: Response?
    var colors: [UIColor]?
    
    func didFetch(withSuccess: @escaping didFetchSuccess, withError: @escaping didFailWithError) {
        API().getCases(withSuccess: { (results) in
            withSuccess(.init(response: results, colors: nil))
        }) { (err) in
            withError(err)
        }
    }
}
