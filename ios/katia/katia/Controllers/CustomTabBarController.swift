//
//  CustomTabBarController.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.addSubview(separator)
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .lightGray
        separator.leftAnchor.constraint(equalTo: tabBar.leftAnchor).isActive = true
        separator.rightAnchor.constraint(equalTo: tabBar.rightAnchor).isActive = true
        separator.topAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        let userControllerLayout = UICollectionViewFlowLayout()
        let userController = UserController(collectionViewLayout: userControllerLayout)
        let userNavController = createNavControllerWithImage(title: "Users", name: "users", controller: userController)
        
        let discussionControllerLayout = UICollectionViewFlowLayout()
        let discussionController = DiscussionController(collectionViewLayout: discussionControllerLayout)
        let discussionNavController = createNavControllerWithImage(title: "Discussions", name: "bubble", controller: discussionController)
        
        let storyControllerLayout = UICollectionViewFlowLayout()
        let storyController = StoryController(collectionViewLayout: storyControllerLayout)
        let storyNavController = createNavControllerWithImage(title: "Stories", name: "image", controller: storyController)
        
        viewControllers = [userNavController, discussionNavController, storyNavController]
    }
    
    private func createNavControllerWithImage(title: String, name:String, controller: UIViewController) -> UINavigationController {
        let navController = UINavigationController(rootViewController: controller)
        navController.tabBarItem = UITabBarItem(title: title, image: UIImage(named: "normal/\(name)"), selectedImage: UIImage(named: "selected/\(name)"))
            
        return navController
    }
    
    let separator: UIView = {
        let sep = UIView()
        sep.translatesAutoresizingMaskIntoConstraints = false
        sep.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        return sep
    }()
}
