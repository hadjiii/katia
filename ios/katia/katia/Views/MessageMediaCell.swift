//
//  MessageMediaCell.swift
//  katia
//
//  Created by Hadji on 08/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class MessageMediaCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        addSubview(image)
        image.leftAnchor.constraint(equalTo: leftAnchor, constant: 2).isActive = true
        image.rightAnchor.constraint(equalTo: rightAnchor, constant: -2).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let image: UIImageView = {
        let img = UIImageView(image: UIImage(named: "image"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        return img
    }()
}
