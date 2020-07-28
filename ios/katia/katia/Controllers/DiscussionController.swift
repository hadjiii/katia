//
//  DiscussionController.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "discussionCell"

class DiscussionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var currentUser = Data.getCurrentUser()
    var discussions = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1)
        
        // Register cell classes
        self.collectionView!.register(DiscussionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
        }
        
        view.addSubview(newDiscussionButton)
        newDiscussionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        newDiscussionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        newDiscussionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        newDiscussionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        discussions = Data.getDiscussions()
        collectionView.reloadData()
    }
    
    let newDiscussionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "selected/plus.bubble")?.withTintColor(.white), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(newDiscussion), for: .touchDown)
        return button
    }()
    
    @objc func newDiscussion() {
        let layout = UICollectionViewFlowLayout()
        let newDiscussionController = NewDiscussionController(collectionViewLayout: layout)
        navigationController?.pushViewController(newDiscussionController, animated: false)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discussions.capacity
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let discussion = self.discussions[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiscussionCell
        
        cell.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        cell.name.text = discussion.senderId == currentUser.id ? Data.getUser(id: discussion.recipientId)?.name : Data.getUser(id: discussion.senderId)?.name
        cell.message.text = discussion.text
        cell.date.text = discussion.date

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let discussion = self.discussions[indexPath.item]
        let layout = UICollectionViewFlowLayout()
        let messageController = MessageController(collectionViewLayout: layout)
        navigationController?.pushViewController(messageController, animated: true)
        
        if discussion.senderId == currentUser.id {
            messageController.userId = discussion.recipientId
            let name = Data.getUser(id: discussion.recipientId)?.name
            messageController.userName = name
        }
        else {
            messageController.userId = discussion.senderId
            let name = Data.getUser(id: discussion.senderId)?.name
            messageController.userName = name
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
}
