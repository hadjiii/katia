//
//  StoryMediaController.swift
//  katia
//
//  Created by Hadji on 14/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "storyMediaCell"

class StoryMediaController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var storyController: StoryController?
    var medias: PHFetchResult<PHAsset>? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        collectionView.register(StoryMediaCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
        
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            let fetchOptions = PHFetchOptions()
            self.medias = PHAsset.fetchAssets(with: fetchOptions)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    let fetchOptions = PHFetchOptions()
                    self.medias = PHAsset.fetchAssets(with: fetchOptions)
                default:
                    self.present(self.alertController, animated: true, completion: nil)
                }
            }
        default:
            self.present(alertController, animated: true, completion: nil)
        }
        
        setupObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = .bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let asset = medias?.object(at: indexPath.row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StoryMediaCell
        cell.image.fetchImage(asset: asset!, contentMode: .aspectFill, targetSize: cell.image.frame.size)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyMedia = medias?.object(at: indexPath.item)
        storyController?.storyMedia = storyMedia
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        return CGSize(width: width, height: width)
    }
    
    lazy var alertController: UIAlertController = {
        let controller = UIAlertController(title: "Permission required", message: "This app needs to have access to photos and videos from your library. ", preferredStyle: .alert)
        
        let settingsButton = UIAlertAction(title: "Open settings", style: .default, handler: openSettings)
        controller.addAction(settingsButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelButton)
        
        return controller
    }()
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMedias), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func openSettings(alert: UIAlertAction) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
    @objc func updateMedias(notification: Notification) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            let fetchOptions = PHFetchOptions()
            self.medias = PHAsset.fetchAssets(with: fetchOptions)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    let fetchOptions = PHFetchOptions()
                    self.medias = PHAsset.fetchAssets(with: fetchOptions)
                default:
                    self.present(self.alertController, animated: true, completion: nil)
                }
            }
        default:
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
