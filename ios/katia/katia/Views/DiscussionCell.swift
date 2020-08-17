//
//  DiscussionCell.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class DiscussionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photo)
        photo.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        photo.heightAnchor.constraint(equalToConstant: 50).isActive = true
        photo.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        
        addSubview(date)
        date.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        date.heightAnchor.constraint(equalToConstant: 20).isActive = true
        //date.widthAnchor.constraint(equalToConstant: 60).isActive = true
        date.widthAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        date.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        addSubview(name)
        name.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 10).isActive = true
        name.rightAnchor.constraint(equalTo: date.leftAnchor, constant: -10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 20).isActive = true
        name.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        addSubview(message)
        message.leftAnchor.constraint(equalTo: photo.rightAnchor, constant: 10).isActive = true
        message.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        message.topAnchor.constraint(equalTo: name.bottomAnchor).isActive = true
        message.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photo: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "normal/user"))
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 25
        avatar.layer.masksToBounds = true
        avatar.backgroundColor = .darkGray
        return avatar
    }()
    
    let message: UILabel = {
        let label = UILabel()
        label.text = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo."
        label.textColor = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let date: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let separator: UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        return sep
    }()
}

