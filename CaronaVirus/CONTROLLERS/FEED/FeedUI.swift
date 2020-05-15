//
//  FeedUI.swift
//  CaronaVirus
//
//  Created Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.


import UIKit
import LBTATools

protocol FeedUIDelegate {
    func uiDidSelect(object: Feed)
    func uiDidPullToRefresh()

}

class FeedUI : UIView {
    var delegate: FeedUIDelegate!
    
    var data : HandleData?
    var cellIdentifier = "FeedCellId"
    var cellIdentifier2 = "MiddleEastCellId"
    var cellIdentifier3 = "AllCountriesCellId"
    
    var isSearching = Bool()
    var searchReasults: [Countries]?
    
    lazy var refreshControl: UIRefreshControl = {
        $0.attributedTitle = NSAttributedString(string: "Pull to refresh")
        $0.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        return $0
    }(UIRefreshControl())

    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.backgroundColor = .clear
        collectionView.refreshControl = refreshControl
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        collectionView.register(MiddleEastCollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier2)
        collectionView.register(AllCountriesCollectionViewCell.self, forCellWithReuseIdentifier: self.cellIdentifier3)

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .init(red: 239, green: 242, blue: 247, alpha: 1)
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupConstraints()
    }
}

extension FeedUI {

    private func setupUIElements() {
        // arrange subviews
        addSubview(self.collectionView)
    }
    
    private func setupConstraints() {
        // add constraints to subviews
        self.collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    @objc func didPullToRefresh(_ sender: Any) {
        self.data = nil
        self.collectionView.reloadData()
        self.delegate.uiDidPullToRefresh()
    }
}

extension FeedUI: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            if isSearching {
                return self.searchReasults?.count ?? 0
            }
            else {
                if let countries = self.data?.sortAllCountries() {
                    return countries.count
                }
            }
            return 0
        }
        else {
            return 1
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! FeedCollectionViewCell
            if let global = self.data?.object?.response?.Global, let country = self.data?.object?.response?.Countries?.first {
                cell.countries = country
                cell.object = global
            }
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier2, for: indexPath) as! MiddleEastCollectionViewCell
            if let countries = self.data?.sortGulf() {
                cell.object = Feed(response: .init(Global: nil, Countries: countries), colors: self.data?.colors)
                cell.collectionView.reloadData()
            }
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier3, for: indexPath) as! AllCountriesCollectionViewCell
            if isSearching {
                if self.searchReasults?.count != 0 {
                    cell.object = searchReasults?[indexPath.row]
                }
            }
            else {
                if let countries = self.data?.sortAllCountries() {
                    cell.object = countries[indexPath.row]
                }

            }
            return cell
        }
        return .init()
    }    
}

extension FeedUI: UICollectionViewDelegate {

}

extension FeedUI: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: frame.width - 30, height: 340)
        }
        else if indexPath.section == 1 {
            return .init(width: frame.width , height: 350)
        }
        return .init(width: frame.width - 40 , height: 290)
    }
}
