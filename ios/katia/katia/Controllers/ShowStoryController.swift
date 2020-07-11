//
//  ShowStoryController.swift
//  katia
//
//  Created by Hadji on 11/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "showStoryCell"

class ShowStoryController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ShowStoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        
        view.addSubview(loader)
        
        let constraints = [
            loader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            loader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            loader.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            loader.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    let loader: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
}
