//
//  NewDiscussionController.swift
//  katia
//
//  Created by Hadji on 28/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class NewDiscussionController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        view.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Search an user"
        sb.backgroundColor = .black
        return sb
    }()
}
