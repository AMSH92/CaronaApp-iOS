//
//  AboutView.swift
//  CaronaVirus
//
//  Created Alsharif Abdullah M on 5/15/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.


import UIKit

protocol AboutViewProtocol {
    func viewWillPresent(data: About)
}

class AboutView: UIViewController, AboutViewProtocol {
    
    private var ui = AboutUI()
    var viewModel = AboutViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchData()
    }
    
    override func loadView() {
        ui.delegate = self
        view = ui
        viewModel.view = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func viewWillPresent(data: About) {
        ui.object = data
    }
}

extension AboutView : AboutUIDelegate {
    func uiDidSelect(object: About) {
        viewModel.didReceiveUISelect(object: object)
    }
}
