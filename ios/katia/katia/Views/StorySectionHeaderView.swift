//
//  StorySectionHeaderView.swift
//  katia
//
//  Created by Hadji on 10/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class StorySectionHeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1)
        
        addSubview(title)
        
        let constraints = [
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            title.topAnchor.constraint(equalTo: topAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
