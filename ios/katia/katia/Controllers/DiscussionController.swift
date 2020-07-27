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
    var discussions = Data.getDiscussions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        
        // Register cell classes
        self.collectionView!.register(DiscussionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        view.addSubview(newDiscussionButton)
        newDiscussionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        newDiscussionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        newDiscussionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        newDiscussionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
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
        print("new discussion")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discussions.capacity
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let discussion = self.discussions[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DiscussionCell
        cell.message.text = discussion.text
        cell.date.text = discussion.date

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let discussion = self.discussions[indexPath.item]
        let layout = UICollectionViewFlowLayout()
        let messageController = MessageController(collectionViewLayout: layout)
        navigationController?.pushViewController(messageController, animated: true)
        messageController.userName = "Username"
        messageController.userId = discussion.senderId == 1 ? discussion.recipientId : discussion.senderId
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
}
