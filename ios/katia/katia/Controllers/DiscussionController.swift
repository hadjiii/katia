//
//  DiscussionController.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "discussionCell"

class DiscussionController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    var currentUser: User?
    var discussions = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Discussions"
        
        let avatarButton = UIButton()
        avatarButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let avatarImage = UIImage(named: "splash")
        let resizedAvatarImage = avatarImage?.resize(targetSize: CGSize(width: 30, height: 30))
        avatarButton.setImage(resizedAvatarImage, for: .normal)
        avatarButton.imageView?.contentMode = .scaleAspectFit
        avatarButton.layer.cornerRadius = 15
        avatarButton.layer.masksToBounds = true
        avatarButton.addTarget(self, action: #selector(toggleSlideMenu), for: .touchUpInside)
        
        let avatarButtonItem = UIBarButtonItem(customView: avatarButton)
        navigationItem.leftBarButtonItem = avatarButtonItem
        
        collectionView.backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1)
        collectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        // Register cell classes
        self.collectionView!.register(DiscussionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
        }
        
        searchBar.delegate = self
        
        view.addSubview(searchBar)
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(searchBarBottomBorder)
        searchBarBottomBorder.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        searchBarBottomBorder.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        searchBarBottomBorder.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        view.addSubview(newDiscussionButton)
        newDiscussionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        newDiscussionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        newDiscussionButton.widthAnchor.constraint(equalToConstant: 56).isActive = true
        newDiscussionButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        
        getCurrentUser()
        fetchDiscussions()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        searchBar.endEditing(true)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.barTintColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)

        let searchBarTextField = sb.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = .white
        searchBarTextField?.backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1)
        
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Search a user in your discussions"
        sb.backgroundColor = .black
        return sb
    }()
    
    let searchBarBottomBorder:  UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        return view
    }()
    
    let newDiscussionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "normal/plus.bubble")?.withTintColor(.white), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(newDiscussion), for: .touchDown)
        return button
    }()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            //self.fecthUsers()
        }
        else {
            //self.fetchUsersWith(keyword: searchText)
        }
        self.collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .green
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
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
        cell.name.text = discussion.senderId == currentUser?.id ? Data.getUser(id: discussion.recipientId)?.username : Data.getUser(id: discussion.senderId)?.username
        cell.message.text = discussion.text
        cell.date.text = discussion.date
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let discussion = self.discussions[indexPath.item]
        let layout = UICollectionViewFlowLayout()
        let messageController = MessageController(collectionViewLayout: layout)
        navigationController?.pushViewController(messageController, animated: true)
        
        if discussion.senderId == currentUser?.id {
            messageController.userId = discussion.recipientId
            let username = Data.getUser(id: discussion.recipientId)?.username
            messageController.userName = username
        }
        else {
            messageController.userId = discussion.senderId
            let username = Data.getUser(id: discussion.senderId)?.username
            messageController.userName = username
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 70)
    }
    
    @objc func toggleSlideMenu() {
        let customTabBarController = tabBarController as! CustomTabBarController
        customTabBarController.toggleSlideMenu()
    }
    
    private func getCurrentUser() {
        do {
            currentUser = try UserService.shared.getCurrentUser()
        }
        catch let error {
            print("getCurrentUserError: \(error)")
        }
    }
    
    private func fetchDiscussions() {
        guard let currentUserId = currentUser?.id else {return}
        
        let result = MessageService.shared.fetchDiscussions(for: currentUserId)
        
        switch result {
        case .success(let discussions):
            self.discussions = discussions
            collectionView.reloadData()
        case .failure(let error):
            print(error)
        }
    }
    
    private func setupNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        
        navigationBar?.barTintColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        navigationBar?.tintColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        navigationBar?.isTranslucent = false
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
