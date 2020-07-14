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
    
    var sectionTitles = [String]()
    let recentSectionTitle = "Recent"
    let readSectionTitle = "Read"
    let stories = [
        "myStories": [],
        "recent": [
            [
                Story(username: "Username1", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "today", status: Status.unread),
                Story(username: "Username1", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ],
            [
                Story(username: "Username2", mediaType: MediaType.video, medialink: "https://katiapp.s3.amazonaws.com/test.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username2", mediaType: MediaType.video, medialink: "https://katiapp.s3.amazonaws.com/test.mp4", date: "yesterday", status: Status.read),
            ],
            [
                Story(username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username3", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username3", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ]
        ],
        "read": [
            [
                Story(username: "Username4", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "today", status: Status.unread),
                Story(username: "Username4", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ],
            [
                Story(username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.unread),
                Story(username: "Username5", mediaType: MediaType.video, medialink: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4", date: "yesterday", status: Status.read),
                Story(username: "Username5", mediaType: MediaType.image, medialink: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/250px-Image_created_with_a_mobile_phone.png", date: "yesterday", status: Status.read)
            ]
        ]
    ]
    
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
        
        if let recentStories =  stories["recent"] {
            if !recentStories.isEmpty {
                sectionTitles.append(recentSectionTitle)
            }
        }
        
        if let readStories =  stories["read"] {
            if !readStories.isEmpty {
                sectionTitles.append(readSectionTitle)
            }
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        let numberOfSection = 1 + sectionTitles.count
        
        return numberOfSection
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        if sectionTitles[section - 1] == recentSectionTitle {
            return stories["recent"]!.count
        }
        
        return stories["read"]!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = indexPath.item
        let section = indexPath.section
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StoryCell
        
        if section == 0 {
            let myStories = stories["myStories"]
            if myStories!.isEmpty {
                cell.name.text = "My Stories"
                cell.date.text = "Press to add a new story"
            }
        }
        else if section == 1 {
            if sectionTitles[0] == recentSectionTitle {
                let recentSectionStories = stories["recent"]
                let lastStoriesPerUser = recentSectionStories![item].last
                cell.name.text = lastStoriesPerUser?.username
                cell.date.text = lastStoriesPerUser?.date
                cell.photo.layer.borderColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1).cgColor
            }
            else {
                let readSectionStories = stories["read"]
                let lastStoriesPerUser = readSectionStories![item].last
                cell.name.text = lastStoriesPerUser?.username
                cell.date.text = lastStoriesPerUser?.date
            }
        }
        else {
            let readSectionStories = stories["read"]
            let lastStoriesPerUser = readSectionStories![item].last
            cell.name.text = lastStoriesPerUser?.username
            cell.date.text = lastStoriesPerUser?.date
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! StorySectionHeaderView
            header.title.text = sectionTitles[indexPath.section - 1]
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
        
        let section = indexPath.section
        
        if section == 0 {
            let currentUserStories = stories["myStories"]
            if currentUserStories!.isEmpty {
                print("add a new story")
                return
            }
            showStoryController.stories = currentUserStories?[indexPath.item]
        }
        else if section == 1 {
            let userStories = stories["recent"]?[indexPath.item]
            showStoryController.stories = userStories
        }
        else if section == 2 {
            let userStories = stories["read"]?[indexPath.item]
            showStoryController.stories = userStories
        }
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


