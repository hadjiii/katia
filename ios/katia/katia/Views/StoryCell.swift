//
//  StoryCell.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class StoryCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photo)
        photo.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        photo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(name)
        name.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 10).isActive = true
        name.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 20).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        addSubview(date)
        date.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 10).isActive = true
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        date.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        date.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let name: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photo: UIView = {
        let avatar = UIView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 25
        avatar.layer.masksToBounds = true
        avatar.backgroundColor = .darkGray
        return avatar
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.text = "today at 16 AM"
        label.textColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separator: UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        return sep
    }()
}

