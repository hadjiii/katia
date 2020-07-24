//
//  StoryMediaPreviewController.swift
//  katia
//
//  Created by Hadji on 15/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit
import Photos
import AVKit

class StoryMediaPreviewController: UIViewController {
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var storyMediaData: NSData?
    var storyMedia: PHAsset? {
        didSet {
            if let storyMedia = storyMedia {
                let options = PHImageRequestOptions()
                options.isNetworkAccessAllowed = false
                
                if  storyMedia.mediaType == PHAssetMediaType.image {
                    PHImageManager().requestImage(for: storyMedia, targetSize: self.view.frame.size, contentMode: .aspectFill, options: options) { (image, infos) in
                        if let data = image?.jpegData(compressionQuality: 50.0) {
                            self.storyMediaData = NSData(data: data)
                        }

                        self.imageView.image = image
                        self.imageView.isHidden = false
                    }
                }
                else {
                    let options = PHVideoRequestOptions()
                    options.isNetworkAccessAllowed = false
                    
                    PHImageManager().requestAVAsset(forVideo: storyMedia, options: options) { (asset, audioMix, info) in
                        let urlAsset = asset as! AVURLAsset
                        
                        self.storyMediaData = NSData(contentsOfFile: urlAsset.url.relativePath)
                        
                        DispatchQueue.main.async {
                            self.player = AVPlayer(url: urlAsset.url)
                            
                            self.playerLayer = AVPlayerLayer(player: self.player)
                            self.playerLayer.videoGravity = .resize
                            
                            self.videoView.layer.addSublayer(self.playerLayer)
                            self.playerLayer.frame = self.videoView.bounds
                            self.playButton.isHidden = false
                            self.videoView.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        extendedLayoutIncludesOpaqueBars = true
        
        view.addSubview(imageView)
        view.addSubview(videoView)
        view.addSubview(playButton)
        view.addSubview(sendButton)
        
        imageView.frame = view.bounds
        videoView.frame = view.bounds
        
        let constraints = [
            playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 56),
            playButton.heightAnchor.constraint(equalToConstant: 56),
            
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            sendButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            sendButton.widthAnchor.constraint(equalToConstant: 56),
            sendButton.heightAnchor.constraint(equalToConstant: 56)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        edgesForExtendedLayout = .bottom
        extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        
        tabBarController?.tabBar.isHidden = false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.isHidden = true
        return view
    }()
    
    let videoView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "selected/send")?.withTintColor(.white), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(send), for: .touchDown)
        return button
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "selected/play")?.withTintColor(.white), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(play), for: .touchDown)
        button.isHidden = true
        return button
    }()
    
    @objc func send() {
        let mediaType: MediaType = storyMedia?.mediaType == PHAssetMediaType.image ? .image : .video
        let story = Story(userId: 1, username: "Me", mediaType: mediaType, status: .read)
        let layout = UICollectionViewFlowLayout()
        let storyController = StoryController(collectionViewLayout: layout)
        storyController.story = story
        navigationController?.pushViewController(storyController, animated: true)
    }
    
    @objc func play() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        playButton.isHidden = true
        self.player.play()
    }
    
    @objc func playerDidFinishPlaying() {
        NotificationCenter.default.removeObserver(self)
        self.player.seek(to: CMTime.zero)
        playButton.isHidden = false
    }
}
