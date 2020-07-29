//
//  StoryMediaCell.swift
//  katia
//
//  Created by Hadji on 14/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class StoryMediaCell: UICollectionViewCell {
    var isVideo: Bool? {
        didSet {
            if let isVideo = isVideo, isVideo == true {
                self.videoIconView.isHidden = false
            }
            else {
                self.videoIconView.isHidden = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 0.2)
        
        addSubview(image)
        addSubview(videoIconView)
        
        image.leftAnchor.constraint(equalTo: leftAnchor, constant: 2).isActive = true
        image.rightAnchor.constraint(equalTo: rightAnchor, constant: -2).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        
        videoIconView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        videoIconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        videoIconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        videoIconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let image: UIImageView = {
        let img = UIImageView(image: UIImage(named: "image"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        img.clipsToBounds = true
        return img
    }()
    
    let videoIconView: UIImageView = {
        let img = UIImageView(image: UIImage(named: "selected/film"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .white
        img.layer.cornerRadius = 5
        img.layer.masksToBounds = true
        return img
    }()
}

