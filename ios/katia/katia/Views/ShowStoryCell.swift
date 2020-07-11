//
//  ShowStoryCell.swift
//  katia
//
//  Created by Hadji on 11/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class ShowStoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
