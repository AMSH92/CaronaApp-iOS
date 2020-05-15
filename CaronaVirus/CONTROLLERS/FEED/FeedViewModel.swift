//
//  FeedViewModel.swift
//  CaronaVirus
//
//  Created Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.


import Foundation
import UIKit

protocol FeedViewModelProtocol {
    func fetchData()
    func didReceiveUISelect(object: Feed)
}

class FeedViewModel {
    var view : FeedViewProtocol!
    var object = Feed()
    
    func fetchData() {
        object.didFetch(withSuccess: { (success) in
            self.view.viewWillPresent(data: success)
        }) { (err) in
            self.fetchData()
            debugPrint("Error happened", err as Any)
        }
    }
    
    func didReceiveUISelect(object: Feed) {
        debugPrint("Did receive UI object", object)
    }
}
