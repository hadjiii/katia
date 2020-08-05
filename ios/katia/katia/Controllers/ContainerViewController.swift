//
//  ContainerViewController.swift
//  katia
//
//  Created by Hadji on 05/08/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    var menuController: MenuController!
    var currentViewController: CustomTabBarController!
    var menuIsExpanded = false
    
    override func viewDidLoad() {
        setupCurrentController()
    }
    
    func setupCurrentController() {
        currentViewController = CustomTabBarController()
        currentViewController.menuDelegate = self
        view.addSubview(currentViewController.view)
        addChild(currentViewController)
        currentViewController.didMove(toParent: self)
    }
    
    func setupMenuController() {
        if menuController == nil {
            let layout = UICollectionViewFlowLayout()
            menuController = MenuController(collectionViewLayout: layout)
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
}

extension ContainerViewController: ContainerDelegate {
    @objc func toggleSlideMenu() {
        if menuIsExpanded {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.currentViewController?.view.frame.origin.x = 0
            }, completion: nil)
        }
        else {
            setupMenuController()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.currentViewController?.view.frame.origin.x = (self.currentViewController?.view.frame.width)! - 80
            }, completion: nil)
        }
        
        menuIsExpanded.toggle()
    }
}
