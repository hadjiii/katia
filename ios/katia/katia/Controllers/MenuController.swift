//
//  MenuController.swift
//  katia
//
//  Created by Hadji on 04/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "menuCell"

class MenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var menuDelegate: ContainerViewController?
    
    override func viewDidLoad() {
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumLineSpacing = 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuItem = MenuItem(rawValue: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
        cell.labelView.text = menuItem?.description
        cell.iconView.image = UIImage.init(systemName: menuItem!.iconName, withConfiguration: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuItem = MenuItem(rawValue: indexPath.item)
        menuDelegate?.toggleSlideMenu(menuItem: menuItem)
    }
}
