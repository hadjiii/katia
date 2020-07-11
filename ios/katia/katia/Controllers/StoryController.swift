//
//  StoryController.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "storyCell"
private let headerReuseIdentifier = "storyHeaderCell"


class StoryController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Stories"
        
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(StorySectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
        }
        
        view.addSubview(mediaButton)
        mediaButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        mediaButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        mediaButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        mediaButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        
        mediaButton.addTarget(self, action: #selector(newStory), for: .touchDown)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 0)
        }
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let showStoryController = ShowStoryController(collectionViewLayout: layout)
        navigationController?.pushViewController(showStoryController, animated: true)
    }
    
    let mediaButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "selected/camera")?.withTintColor(.white), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        return button
    }()
    
    @objc private func newStory() {
        print("new story")
    }
}


