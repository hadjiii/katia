//
//  MenuCell.swift
//  katia
//
//  Created by Hadji on 07/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubview(iconView)
        addSubview(labelView)
        
        let constraints = [
            iconView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            iconView.widthAnchor.constraint(equalToConstant: 34),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            labelView.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 8),
            labelView.rightAnchor.constraint(equalTo: rightAnchor, constant: -150),
            labelView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    let iconView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let labelView: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
