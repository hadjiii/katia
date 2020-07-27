//
//  NewDiscussionController.swift
//  katia
//
//  Created by Hadji on 28/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "newDiscussionCell"
class NewDiscussionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var users = Data.getUsers()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        collectionView.register(NewDiscussionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
        }
        
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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = users[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewDiscussionCell
        cell.name.text = user.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = users[indexPath.item]
        
        let layout = UICollectionViewFlowLayout()
        let messageController = MessageController(collectionViewLayout: layout)
        messageController.userId = user.id
        navigationController?.pushViewController(messageController, animated: false)
    }
}
