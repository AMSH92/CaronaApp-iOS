//
//  AboutTableViewCell.swift
//  CaronaVirus
//
//  Created by Alsharif Abdullah M on 5/15/20.
//  Copyright © 2020 Alsharif Abdullah M. All rights reserved.
//

import UIKit
import Material
import ChameleonFramework

class AboutTableViewCell: UITableViewCell {
    
    fileprivate var logoImageView: UIImageView = {
        $0.image = #imageLiteral(resourceName: "coronavirus (1)")
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    fileprivate var twitterButton: RaisedButton = {
        return $0
    }(RaisedButton())
    
    fileprivate lazy var cellBackgroundView: UIView = {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .clear
        
        $0.addSubview(textView)
        textView.anchor(top: $0.topAnchor, leading: $0.leadingAnchor, bottom: $0.bottomAnchor, trailing: $0.trailingAnchor, padding: .init(top: 5, left: 5, bottom: 5, right: 5))
//        $0.setupShadow(opacity: 0.7, radius: 12, offset: .init(width: 0, height: 0), color: .lightGray)
        return $0
    }(UIView())
    
    fileprivate lazy var cellBackgroundView2: UIView = {
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .white
        let appLabel = UILabel()
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        appLabel.textAlignment = .center
        appLabel.font = .systemFont(ofSize: 15)
        appLabel.text = "إصدار التطبيق: \(appVersion ?? "")"
        $0.addSubview(appLabel)
        appLabel.anchor(top: $0.topAnchor, leading: $0.leadingAnchor, bottom: $0.bottomAnchor, trailing: $0.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        return $0
    }(UIView())
    
    fileprivate lazy var textView: UILabel = {
        $0.textAlignment = .right
        $0.backgroundColor = .clear
        $0.textColor = UIColor.flatBlack()
        $0.font = .systemFont(ofSize: 15)
        $0.numberOfLines = 0
        $0.isUserInteractionEnabled = true

        let title = "تطبيق كم حالة ؟ هوا تطبيق يساعد على تتبع حالات فيروس كارونا (COVID-19) حول العالم. \n\n المصدر: \n مصدر المعلومات عن المدن و الحالات من جامعة جون هوبكنز Johns Hopkins CSSE \n\n برمجة: عبدالله الشريف"
        let underlineAttriString = NSMutableAttributedString(string: title)
        let range = (title as NSString).range(of: "Johns Hopkins CSSE")
        let range2 = (title as NSString).range(of: "عبدالله الشريف")

        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        underlineAttriString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range2)

        $0.attributedText = underlineAttriString
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:)))
        $0.addGestureRecognizer(tap)
        
        return $0
    }(UILabel())
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func tapLabel(gesture: UITapGestureRecognizer) {
        let range = (textView.text! as NSString).range(of: "Johns Hopkins CSSE")
        let range2 = (textView.text! as NSString).range(of: "عبدالله الشريف")

        if gesture.didTapAttributedTextInLabel(label: textView, inRange: range) {
            guard let url = URL(string: "https://github.com/CSSEGISandData/COVID-19") else { return }
            UIApplication.shared.open(url)
        } else if gesture.didTapAttributedTextInLabel(label: textView, inRange: range2) {
            didPressTwitterButton()
        } else {
           print("Tapped none")
       }
    }
    
    @objc func didPressTwitterButton() {
          let screenName =  "Al5harif"
           let appURL = NSURL(string: "twitter://user?screen_name=\(screenName)")!
           let webURL = NSURL(string: "https://twitter.com/\(screenName)")!

           let application = UIApplication.shared

           if application.canOpenURL(appURL as URL) {
                application.open(appURL as URL)
           } else {
                application.open(webURL as URL)
           }
    }
    
    @objc func didPressDigitalButton() {
        guard let url = URL(string: "https://www.digitalocean.com/") else { return }
        UIApplication.shared.open(url)
    }
}

extension AboutTableViewCell {
    
    fileprivate func setViews() {
        addSubview(self.logoImageView)
        self.addSubview(textView)
        
        let digitalOceanImage = UIImageView(image: #imageLiteral(resourceName: "digitalocean-1-283338"))
        digitalOceanImage.isUserInteractionEnabled = true
        
        addSubview(digitalOceanImage)
        setConstraints()
        
        let label = UILabel()
        label.text = "This project is supported by:"
        label.textColor = .lightGray
        label.textAlignment = .center
        addSubview(label)
        
        label.anchor(top: textView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: 150, height: 150))

        digitalOceanImage.anchor(top: label.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: -100, left: 0, bottom: 0, right: 0), size: .init(width: 150, height: 150))
        digitalOceanImage.centerXTo(centerXAnchor)
        digitalOceanImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didPressDigitalButton)))
    }
    
    fileprivate func setConstraints() {
        logoImageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        logoImageView.centerXTo(centerXAnchor)
        
        textView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 100, left: 40, bottom: 0, right: 40))
                
    }
}
