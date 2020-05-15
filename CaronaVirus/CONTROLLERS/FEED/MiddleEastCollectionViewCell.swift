//
//  MiddleEastCollectionViewCell.swift
//  CaronaVirus
//
//  Created by Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.
//

import UIKit

class MiddleEastCollectionViewCell: UICollectionViewCell {
    
    var cellIdentifier = "MiddleEastCell"
    var object: Feed?
    
    
    lazy var collectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false 
        collectionView.register(MiddleEastCell.self, forCellWithReuseIdentifier: self.cellIdentifier)
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 0)
        }
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setConstraints()
    }
}

extension MiddleEastCollectionViewCell {
    fileprivate func setViews(){
        addSubview(self.collectionView)
    }
    
    fileprivate func setConstraints() {
        self.collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
}

extension MiddleEastCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.object?.response?.Countries?.count != 0 {
            return  6
        } else {
            return  0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! MiddleEastCell
        if let country = self.object?.response?.Countries?[indexPath.row] {
            cell.country = country
            cell.color = self.object?.colors?[indexPath.row]
        }

        return cell
    }
}

extension MiddleEastCollectionViewCell: UICollectionViewDelegate {
    
}

extension MiddleEastCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: frame.width / 2, height: frame.height - 40)
    }
}
