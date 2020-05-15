//
//  MiddleEastCell.swift
//  CaronaVirus
//
//  Created by Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.
//

import UIKit
import Kingfisher
import ChameleonFramework

class MiddleEastCell: UICollectionViewCell {
    
    fileprivate var labelsTitle = ["الوفيات الجديدة","مجموع الوفيات","التعافي الجديدة","مجموع التعافي","مجموع الحالات"]
    
    fileprivate var flagImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    fileprivate var countryNameLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = .white
        return $0
    }(UILabel())
    
    fileprivate var totalConfirmedLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = .white
        return $0
    }(UILabel())

    
    fileprivate lazy var flagView: UIView = {
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = 5
        $0.addSubview(self.flagImageView)
        self.flagImageView.anchor(top: $0.topAnchor, leading: $0.leadingAnchor, bottom: $0.bottomAnchor, trailing: $0.trailingAnchor)
       // $0.setupShadow(opacity: 0.7, radius: 12, offset: .init(width: 0, height: 0), color: .lightGray)
        return $0
    }(UIView())
    
    fileprivate let totalLabelsVStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fillProportionally
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    fileprivate let totalConfirmedLabelsVStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    fileprivate lazy var cellBackgroundView: UIView = {
       $0.backgroundColor = .white
       $0.roundTopRight(radius: 65)
       $0.setupShadow(opacity: 0.7, radius: 20, offset: .init(width: 0, height: 0), color: .lightGray)
        
        $0.addSubview(self.countryNameLabel)
        self.countryNameLabel.anchor(top: $0.topAnchor, leading: $0.leadingAnchor, bottom: nil, trailing: $0.trailingAnchor, padding: .init(top: 25, left: 5, bottom: 5, right: 5))
        
        (0...3).forEach({

            let hStack = UIStackView()
            hStack.tag = $0 + 5
            hStack.distribution = .fillProportionally
            hStack.axis = .horizontal
            hStack.spacing = 5
            

            let label2 = UILabel()
            label2.text = self.labelsTitle[$0]
            label2.textColor = .white
            label2.textAlignment = .center
            label2.tag = $0 + 10
            hStack.addArrangedSubview(label2)
            
            
            let label = UILabel()
            label.text = self.labelsTitle[$0]
            label.font = .systemFont(ofSize: 13, weight: .bold)
            label.textColor = .white
            hStack.addArrangedSubview(label)
            self.totalLabelsVStack.addArrangedSubview(hStack)
        })
        
        (0...1).forEach({
            let label = UILabel()
            label.text = self.labelsTitle.last
            label.font = .systemFont(ofSize: 13, weight: .bold)
            label.textColor = .white
            label.tag = $0 + 1
            label.numberOfLines = 2
            label.textAlignment = .center
            self.totalConfirmedLabelsVStack.addArrangedSubview(label)
        })
        
        $0.addSubview(self.totalLabelsVStack)
        self.totalLabelsVStack.anchor(top: nil, leading: $0.leadingAnchor, bottom: nil, trailing: $0.trailingAnchor, padding: .init(top: 75, left: 0, bottom: 10, right: 0))
        totalLabelsVStack.centerYTo($0.centerYAnchor)
        $0.addSubview(totalConfirmedLabelsVStack)
        totalConfirmedLabelsVStack.anchor(top: nil, leading: $0.leadingAnchor, bottom: $0.bottomAnchor, trailing: $0.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 10, right: 10))
        totalConfirmedLabelsVStack.centerXTo($0.centerXAnchor)

        
       return $0
   }(UIView())
    
    var country: Countries! {
        didSet {
            self.flagImageView.kf.setImage(with: URL(string: "https://www.countryflags.io/\(self.country.CountryCode ?? "")/shiny/64.png"))
            self.countryNameLabel.text = self.country.Country
            
            if let label = self.totalConfirmedLabelsVStack.viewWithTag(1) as? UILabel {
                label.text = self.country.TotalConfirmed?.description
                label.font = .boldSystemFont(ofSize: 20)
            }
            
            (0...self.totalLabelsVStack.arrangedSubviews.count).forEach({ count in
                if let stackView = self.totalLabelsVStack.viewWithTag(count + 5) as? UIStackView {
                    stackView.arrangedSubviews.forEach({ v in
                        if let label = v.viewWithTag(count + 10) as? UILabel {
                            label.font = .systemFont(ofSize: 13, weight: .bold)

                            switch label.tag {
                            case 10:
                                label.text = self.country.NewDeaths?.description
                            case 11:
                                label.text = self.country.TotalDeaths?.description
                            case 12:
                                label.text = self.country.NewRecovered?.description
                            case 13:
                                label.text = self.country.TotalRecovered?.description
                            case 14:
                                break
                            default:
                                break
                            }
                        }
                    })
                }
            })
            self.cellBackgroundView.alpha = 1
        }
    }
    
    var color : UIColor! {
        didSet {
            self.cellBackgroundView.backgroundColor = color
            self.cellBackgroundView.setupShadow(opacity: 0.7, radius: 12, offset: .init(width: 0, height: 0), color: color)
            self.cellBackgroundView.alpha = 1

        }
    }
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellBackgroundView.alpha = 0
    }
}

extension MiddleEastCell {
        
    fileprivate func setViews(){
        addSubview(self.cellBackgroundView)
        addSubview(self.flagView)
    }
    
    fileprivate func setConstraints() {
        self.cellBackgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        
        self.flagView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: -2, left: 0, bottom: 0, right: 0), size: .init(width: 40, height: 30))
        
        self.flagView.centerXTo(self.cellBackgroundView.centerXAnchor)
        
    }
}

extension MiddleEastCell {
    
}
