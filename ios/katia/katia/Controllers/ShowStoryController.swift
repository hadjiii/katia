//
//  ShowStoryController.swift
//  katia
//
//  Created by Hadji on 11/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "showStoryCell"

class ShowStoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout, ShowStoryCellDelegate {
    var stories: [Story]? {
        didSet {
            print("stories did set")
            navigationItem.title = stories?.first?.username
            if let pageControlNumberOfPages = stories?.count {
                pageControl.numberOfPages = pageControlNumberOfPages
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        extendedLayoutIncludesOpaqueBars = true
        
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(ShowStoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        view.addSubview(pageControl)
        
        let constraints = [
            pageControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            pageControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            pageControl.heightAnchor.constraint(equalToConstant: 2)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ShowStoryCell
        cell.story = stories![indexPath.item]
        cell.delegate = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    
    func slideToNextStory(currentCell: ShowStoryCell) {
        guard let currentCellItem = collectionView.indexPath(for: currentCell)?.item else {return}
        let nextItemIndex = currentCellItem + 1
        guard let storiesCount = stories?.count else {return}
        
        if nextItemIndex < storiesCount {
            let nextCellIndexPath = IndexPath(item: nextItemIndex, section: 0)
            collectionView.scrollToItem(at: nextCellIndexPath, at: UICollectionView.ScrollPosition.right, animated: true)
            pageControl.currentPage = 1
        }
        else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.translatesAutoresizingMaskIntoConstraints = false
        control.currentPage = 0
        return control
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
