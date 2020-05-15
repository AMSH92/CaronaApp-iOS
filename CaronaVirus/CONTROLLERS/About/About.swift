//
//  About.swift
//  CaronaVirus
//
//  Created Alsharif Abdullah M on 5/15/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.


/// About Model
struct  About {
    typealias didFetchSuccess = (About)->()
    typealias didFailWithError = (Error?) -> ()
    
    // Your Model Structure
    
    func didFetch(withSuccess: @escaping didFetchSuccess, withError: @escaping didFailWithError) {
        withSuccess(About())
        withError(nil)
    }
}
