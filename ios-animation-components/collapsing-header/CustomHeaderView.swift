//
//  CustomHeaderView.swift
//  ios-animation-components
//
//  Created by De MicheliStefano on 02.09.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import UIKit

class CustomHeaderView: UIView {

    var imageView: UIImageView!
    var colorView: UIView!
    var bgColor = UIColor(red: 235/255, green: 96/255, blue: 91/255, alpha: 1)
    var titleLabel = UILabel()
    var headerIcon: UIImageView!
    
    init(frame: CGRect, title: String) {
        self.titleLabel.text = title.uppercased()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        // The general pattern when using autolayout programmatically with any view is to first initialize the view, set its translatesAutoresizingMaskIntoConstraints property to false, add it to the view, set the constraints, activate the constraints, and then set all its properties, fonts, text, image etc.
        
        // Header view
        self.backgroundColor = UIColor.white
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        
        colorView = UIView()
        colorView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(colorView)
        
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            colorView.topAnchor.constraint(equalTo: self.topAnchor),
            colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        imageView.image = UIImage(named: "liebling")
        // Aspect fill will scale the image with the view's frame (when we pull it down it will have a zoom-like effect)
        imageView.contentMode = .scaleAspectFill
        
        colorView.backgroundColor = bgColor
        colorView.alpha = 0.6
        
        // Title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        
        let titlesConstraints: [NSLayoutConstraint] = [
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
        ]
        NSLayoutConstraint.activate(titlesConstraints)
        
        titleLabel.font = UIFont.systemFont(ofSize: 15.0)
        titleLabel.textAlignment = .center
        
        // Header icon
        headerIcon = UIImageView()
        headerIcon.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(headerIcon)
        
        let imageConstraints: [NSLayoutConstraint] = [
            headerIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            headerIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 6),
            headerIcon.widthAnchor.constraint(equalToConstant: 40.0),
            headerIcon.heightAnchor.constraint(equalToConstant: 40.0),
        ]
        NSLayoutConstraint.activate(imageConstraints)
        
        headerIcon.image = UIImage(named: "heart")
        
    }
    
    func decrementColorAlpha(with offset: CGFloat) {
        if self.colorView.alpha <= 1 {
            let alphaOffset = (offset/500)/85
            self.colorView.alpha = alphaOffset
        }
    }
    
    func decrementIconAlpha(with offset: CGFloat) {
        if self.headerIcon.alpha >= 0 {
            let alphaOffset = max((offset - 65)/85.0, 0)
            self.headerIcon.alpha = alphaOffset
        }
    }
    
    func incrementColorAlpha(with offset: CGFloat) {
        if self.colorView.alpha >= 0.6 {
            let alphaOffset = (offset/200)/85
            self.colorView.alpha -= alphaOffset
        }
    }
    
    func incrementIconAlpha(with offset: CGFloat) {
        if self.headerIcon.alpha <= 1 {
            let alphaOffset = max((offset - 65)/85, 0)
            self.headerIcon.alpha = alphaOffset
        }
    }

}
