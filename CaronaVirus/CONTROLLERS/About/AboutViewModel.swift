//
//  AboutViewModel.swift
//  CaronaVirus
//
//  Created Alsharif Abdullah M on 5/15/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.


import Foundation

protocol AboutViewModelProtocol {
    func fetchData()
    func didReceiveUISelect(object: About)
}

class AboutViewModel {
    var view : AboutViewProtocol!
    var object = About()
    
    func fetchData() {
        object.didFetch(withSuccess: { (success) in
            self.view.viewWillPresent(data: success)
        }) { (err) in
            debugPrint("Error happened", err as Any)
        }
    }
    
    func didReceiveUISelect(object: About) {
        debugPrint("Did receive UI object", object)
    }
}
