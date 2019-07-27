//
//  PrimaryTableViewCell.swift
//  Beer Craft
//
//  Created by Subham Padhi on 27/07/19.
//  Copyright © 2019 Subham Padhi. All rights reserved.
//

import Foundation
import UIKit

class PrimaryTableViewCell: UITableViewCell {
    
    var plusTappedClosure: (()->())?
    var minusTappedClosure: (()->())?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        initViews()
    }
    
    var cardView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.3
        view.layer.cornerRadius = 3.0
        return view
    }()
    
    var bottomView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.5725490196, blue: 0.137254902, alpha: 1)
        return view
    }()
    
    var hiddenLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = #colorLiteral(red: 0.9058823529, green: 0.6039215686, blue: 0.1921568627, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    var trailingView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9568627451, blue: 0.9019607843, alpha: 1)
        return view
    }()
    
    var topLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        label.textColor = #colorLiteral(red: 0.9058823529, green: 0.6039215686, blue: 0.1921568627, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    var percentLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = #colorLiteral(red: 0.9058823529, green: 0.6039215686, blue: 0.1921568627, alpha: 1)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    var leadingImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var plusImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "add")
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var minusImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = UIView.ContentMode.scaleAspectFill
        image.clipsToBounds = true
        image.image = #imageLiteral(resourceName: "minus")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isUserInteractionEnabled = true
        return image
    }()
    
    var orderCountLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        
        label.numberOfLines = 0
        return label
    }()
    
    var bottomLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func plusTapped() {
       plusTappedClosure?()
    }
    
    @objc func minusTapped() {
        minusTappedClosure?()
    }
    
    func initViews() {
        contentView.addSubview(cardView)

        cardView.addSubview(leadingImage)
        cardView.addSubview(trailingView)
        cardView.addSubview(topLabel)
        cardView.addSubview(bottomLabel)
        cardView.addSubview(bottomView)
        bottomView.addSubview(percentLabel)
        cardView.addSubview(hiddenLabel)
        
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        leadingImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 15).isActive = true
        leadingImage.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 15).isActive = true
        
        leadingImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        leadingImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        leadingImage.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        trailingView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        trailingView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        trailingView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        trailingView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        topLabel.leadingAnchor.constraint(equalTo: leadingImage.trailingAnchor, constant: 15).isActive = true
        topLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: trailingView.leadingAnchor, constant: -5).isActive = true
        
        bottomLabel.leadingAnchor.constraint(equalTo:topLabel.leadingAnchor).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor).isActive = true
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor , constant: 10).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 10).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        bottomView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        percentLabel.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        percentLabel.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        
        hiddenLabel.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 10).isActive = true
        hiddenLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -2).isActive = true
        hiddenLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
        
        trailingView.addSubview(plusImage)
        trailingView.addSubview(minusImage)
        trailingView.addSubview(orderCountLabel)
        
        orderCountLabel.centerXAnchor.constraint(equalTo: trailingView.centerXAnchor).isActive = true
        orderCountLabel.centerYAnchor.constraint(equalTo: trailingView.centerYAnchor).isActive = true
        
        plusImage.centerXAnchor.constraint(equalTo: trailingView.centerXAnchor).isActive = true
        plusImage.bottomAnchor.constraint(equalTo: orderCountLabel.topAnchor , constant: -10).isActive = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(plusTapped))
        plusImage.addGestureRecognizer(tap)

        minusImage.centerXAnchor.constraint(equalTo: trailingView.centerXAnchor).isActive = true
        minusImage.topAnchor.constraint(equalTo: orderCountLabel.bottomAnchor , constant: 10).isActive = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(minusTapped))
        minusImage.addGestureRecognizer(tap2)
    }
}

