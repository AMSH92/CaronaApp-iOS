//
//  AllCountriesCollectionViewCell.swift
//  CaronaVirus
//
//  Created by Alsharif Abdullah M on 5/14/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.
//

import UIKit

class AllCountriesCollectionViewCell: UICollectionViewCell {
    
    fileprivate let labelTitleArray = ["عدد الوفيات","عدد الشفاء"]
    fileprivate let totalLabelTitleArray = ["مجموع الوفيات","مجموع الشفاء", "مجموع الحالات"]

    fileprivate let sepratorColorsArray: [UIColor] = [UIColor.flatRed(),UIColor.flatMint(), UIColor.flatYellowColorDark()]

    fileprivate var flagImageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    fileprivate var countryNameLabel: UILabel = {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.textColor = .black
        return $0
    }(UILabel())
    
    fileprivate let hStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    fileprivate let labelHStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalCentering
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    fileprivate let sepratorVStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 25
        return $0
    }(UIStackView())
    
    fileprivate let totalLabelsVStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.spacing = 25
        return $0
    }(UIStackView())
    
    fileprivate let labelsVStack: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 20
        return $0
    }(UIStackView())
    
    fileprivate lazy var cellBackgroundView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
        $0.setupShadow(opacity: 0.7, radius: 20, offset: .init(width: 0, height: 0), color: .lightGray)
        
        $0.addSubview(self.flagImageView)
        self.flagImageView.anchor(top: $0.topAnchor, leading: nil, bottom: nil, trailing: $0.trailingAnchor, padding: .init(top: 20, left: 0, bottom: 20, right: 30), size: .init(width: 70, height: 55))
        
        $0.addSubview(self.countryNameLabel)
        self.countryNameLabel.anchor(top: self.flagImageView.bottomAnchor, leading: nil, bottom: nil, trailing: $0.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 20))
        self.countryNameLabel.centerXTo(self.flagImageView.centerXAnchor)
        
        (0...1).forEach {
            let labelVStack = UIStackView()
            labelVStack.axis = .vertical
            labelVStack.alignment = .center
            labelVStack.distribution = .fillProportionally
            labelVStack.spacing = 5
            
            let sepratedView = UIView()
            sepratedView.backgroundColor = sepratorColorsArray[$0]
            self.sepratorVStack.addArrangedSubview(sepratedView.withHeight(40).withWidth(2))
            
            let titlelabel = UILabel()
            titlelabel.tag = 5 + $0
            titlelabel.textAlignment = .center

            titlelabel.font = .systemFont(ofSize: 13, weight: .regular)
            titlelabel.text = labelTitleArray[$0]
            labelVStack.addArrangedSubview(titlelabel)

            let label = UILabel()
            label.tag = 15 + $0
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 18)
            labelVStack.addArrangedSubview(label)
            
            self.labelsVStack.addArrangedSubview(labelVStack)
        }

        $0.addSubview(self.sepratorVStack)
        self.sepratorVStack.anchor(top: $0.topAnchor, leading: $0.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 30, left: 20, bottom: 0, right: 0))
        
        $0.addSubview(self.labelsVStack)
        self.labelsVStack.anchor(top: nil, leading: self.sepratorVStack.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        self.labelsVStack.centerYTo(self.sepratorVStack.centerYAnchor)
        
        let sepratorView = UIView()
        sepratorView.backgroundColor = .init(white: 0.93, alpha: 1)
        $0.addSubview(sepratorView)
        sepratorView.anchor(top: self.labelsVStack.bottomAnchor, leading: $0.leadingAnchor, bottom: nil, trailing: $0.trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20), size: .init(width: 0, height: 2))
        
        (0...2).forEach({

            let labelVStack = UIStackView()
            labelVStack.axis = .vertical
            labelVStack.alignment = .center
            labelVStack.distribution = .fill
            labelVStack.spacing = 10

            labelVStack.tag = $0
 
            let seprator = UIView().withHeight(2).withWidth(65)
            seprator.backgroundColor = sepratorColorsArray[$0]
            seprator.centerInSuperview()
            
            let titlelabel = UILabel()
            titlelabel.font = .systemFont(ofSize: 13, weight: .regular)
            titlelabel.text = totalLabelTitleArray[$0]
            titlelabel.textAlignment = .center

            labelVStack.addArrangedSubview(titlelabel)
            
            let label = UILabel()
            label.tag = 15 + $0
            label.text = ""
            label.textAlignment = .center
            label.font = .boldSystemFont(ofSize: 16)
            labelVStack.addArrangedSubview(titlelabel)
            labelVStack.addArrangedSubview(seprator)
            labelVStack.addArrangedSubview(label)

            labelHStack.addArrangedSubview(labelVStack)
        })
        
        $0.addSubview(self.labelHStack)
        
        
        self.labelHStack.anchor(top: sepratorView.bottomAnchor, leading: $0.leadingAnchor, bottom: $0.bottomAnchor, trailing: $0.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        return $0
    }(UIView())
    
    var object: Countries! {
        didSet {
            self.flagImageView.kf.setImage(with: URL(string: "https://www.countryflags.io/\(self.object.CountryCode ?? "")/shiny/64.png"))
            self.countryNameLabel.text = self.object.Country
            
            labelsVStack.arrangedSubviews.forEach { (view) in
                if let labelVStack = view as? UIStackView {
                    labelVStack.arrangedSubviews.forEach { (label) in
                        if let label = label as? UILabel {
                            switch label.tag {
                            case 15:
                                label.text = self.object.NewDeaths?.description
                            case 16:
                                label.text = self.object.NewRecovered?.description
                            default:
                                break
                            }
                        }
                    }
                }
            }
            labelHStack.arrangedSubviews.forEach { (view) in
                if let labelVStack = view as? UIStackView {
                    labelVStack.arrangedSubviews.forEach { (label) in
                        if let label = label as? UILabel {            label.textAlignment = .center

                            switch label.tag {
                            case 15:
                                label.text = self.object.TotalDeaths?.description
                            case 16:
                                label.text = self.object.TotalRecovered?.description
                            case 17:
                                label.text = self.object.TotalConfirmed?.description
                            default:
                                break
                            }
                        }
                    }
                }
            }
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
}

extension AllCountriesCollectionViewCell {
        
    fileprivate func setViews(){
        addSubview(self.cellBackgroundView)
    }
    
    fileprivate func setConstraints() {
        self.cellBackgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}

extension AllCountriesCollectionViewCell {
    
}
