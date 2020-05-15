//
//  FeedView.swift
//  CaronaVirus
//
//  Created Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.


import UIKit
import Material

protocol FeedViewProtocol {
    func viewWillPresent(data: Feed)
}

class FeedView: UIViewController, FeedViewProtocol {
    
    private var ui = FeedUI()
    var viewModel = FeedViewModel()
    private let search = UISearchController(searchResultsController: nil)
    private var lastSearch = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
    }
    
    override func loadView() {
        setNavigationViewLayout()
        ui.delegate = self
        view = ui
        viewModel.view = self
    }
    
    func viewWillPresent(data: Feed) {
        let hdata = HandleData()
        hdata.object = data
        ui.data = hdata
        
        DispatchQueue.main.async {
            self.ui.collectionView.isHidden = false
            self.ui.collectionView.reloadData()
            self.ui.refreshControl.endRefreshing()
        }
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.ui.refreshControl.beginRefreshing()
            UIView.animate(withDuration: 0.8, animations: {
                self.ui.collectionView.setContentOffset(CGPoint(x: 0, y: self.ui.collectionView.contentOffset.y - self.ui.frame.height), animated: false)
            }) { (sucess) in
                if sucess {
                    self.ui.didPullToRefresh(self)
                }
            }
        }
    }
}
extension FeedView {

    fileprivate func setNavigationViewLayout() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
        
        let notificationButton = RaisedButton(image: Icon.cm.moreHorizontal!, tintColor: .lightGray, target: self, action: #selector(self.didPressAboutus))
              self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: notificationButton)
        addNavBarImage()
    }
    
    fileprivate func addNavBarImage() {
         let image = #imageLiteral(resourceName: "coronavirus (1)")
         let imageView = UIImageView(image: image)
         imageView.constrainWidth(30)
         imageView.constrainHeight(30)
         imageView.contentMode = .scaleAspectFill
         navigationItem.titleView = imageView
         
         UIView.animate(withDuration: 0.5) {
             self.navigationController?.navigationBar.isTranslucent = true
         }
     }
    
    @objc func didPressAboutus() {
        self.present(AboutView(), animated: true, completion: nil)
    }
     
}

extension FeedView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.delegate = self
    }
}
extension FeedView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.ui.isSearching = false
            self.ui.collectionView.reloadSections(.init(integer: 2))
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            self.ui.collectionView.scrollToItem(at: .init(row: 1, section: 2), at: .bottom, animated: true)
            let searchResults = self.ui.data?.searchGlobal(searchText: searchBar.text!)
            if searchBar.text! == "" {
                self.ui.isSearching = false
            }
            else {
                self.ui.isSearching = true
                self.ui.searchReasults = searchResults ?? self.ui.data?.sortAllCountries()
            }
            self.lastSearch = searchBar.text!
            self.ui.collectionView.reloadSections(.init(integer: 2))
            self.ui.collectionView.scrollToItem(at: .init(row: 0, section: 2), at: .bottom, animated: true)
            
            if self.ui.isSearching == true {
                searchBar.searchTextField.text = searchBar.text!

            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            if self.ui.isSearching == true {
                self.navigationItem.searchController?.searchBar.text = self.lastSearch
            }
        }
    }
}
extension FeedView : FeedUIDelegate {
    func uiDidPullToRefresh() {
        self.viewModel.fetchData()
    }
    
    func uiDidSelect(object: Feed) {
        viewModel.didReceiveUISelect(object: object)
    }
}
