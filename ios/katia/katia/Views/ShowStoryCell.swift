//
//  ShowStoryCell.swift
//  katia
//
//  Created by Hadji on 11/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ShowStoryCell: UICollectionViewCell {
    lazy var imageDisplayTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { (timer) in
        self.delegate.slideToNextStory(currentCell: self)
    }
    var delegate: ShowStoryCellDelegate!
    var imageConstraints: [NSLayoutConstraint]!
    var videoConstraints: [NSLayoutConstraint]!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var story: Story? {
        didSet {
            guard let mediaLink = story?.medialink else {return}
            guard let url = URL(string: mediaLink) else {return}
            print("story \(url)")
            
            switch story?.mediaType {
            case .image:
                NSLayoutConstraint.activate(imageConstraints)
                URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                    if let e = error {
                        print("Error downloading cat picture: \(e)")
                    } else {
                        if let res = response as? HTTPURLResponse {
                            print("Downloaded cat picture with response code \(res.statusCode)")
                            if let imageData = data {
                                // Finally convert that Data into an image and do what you wish with it.
                                let image = UIImage(data: imageData)
                                DispatchQueue.main.async {
                                    self.imageView.image = image
                                    RunLoop.current.add(self.imageDisplayTimer, forMode: RunLoop.Mode.common)
                                }
                            } else {
                                print("Couldn't get image: Image is nil")
                            }
                        } else {
                            print("Couldn't get response code for some reason")
                        }
                    }
                }.resume()
            case .video:
                // Create an AVPlayer, passing it the HTTP Live Streaming URL.
                NSLayoutConstraint.activate(videoConstraints)
                player = AVPlayer(url: url)
                playerLayer = AVPlayerLayer(player: player)
                playerLayer.videoGravity = .resize
                videoView.layer.addSublayer(playerLayer)
                playerLayer.frame = self.bounds
                print("playerLayer.frame  \(playerLayer.frame)")
                player.play()
            default:
                print("error")
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        
        let imageSize = UIImage(named: "splash")?.size
        print("frame \(frame)")
        print("imageSize \(imageSize)")
        
        let mediaAspectRatio = CGFloat(imageSize!.width) / CGFloat(imageSize!.height)
        
        var ajustedWidth: CGFloat = imageSize!.width
        var ajustedHeight: CGFloat = imageSize!.height
        
        if ajustedWidth > frame.width {
            ajustedWidth = frame.width * mediaAspectRatio
            ajustedHeight = ajustedWidth / mediaAspectRatio
        }
        
        if ajustedHeight > frame.height {
            ajustedHeight = frame.height * mediaAspectRatio
            ajustedWidth = ajustedHeight * mediaAspectRatio
        }
        
        print(ajustedWidth, ajustedHeight)
        
        addSubview(imageView)
        addSubview(videoView)
        
        imageConstraints = [
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        videoConstraints = [
            videoView.leftAnchor.constraint(equalTo: leftAnchor),
            videoView.rightAnchor.constraint(equalTo: rightAnchor),
            videoView.topAnchor.constraint(equalTo: topAnchor),
            videoView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        /*if story?.mediaType == MediaType.video {
         print("is ==> Video")
         addSubview(videoView)
         
         constraints = [
         videoView.leftAnchor.constraint(equalTo: leftAnchor),
         videoView.rightAnchor.constraint(equalTo: rightAnchor),
         videoView.topAnchor.constraint(equalTo: topAnchor),
         videoView.bottomAnchor.constraint(equalTo: bottomAnchor)
         ]
         }
         else {
         print("is ==> Image")
         addSubview(imageView)
         
         constraints = [
         /*imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
         imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
         imageView.widthAnchor.constraint(equalToConstant: ajustedWidth),
         imageView.heightAnchor.constraint(equalToConstant: ajustedHeight)*/
         imageView.leftAnchor.constraint(equalTo: leftAnchor),
         imageView.rightAnchor.constraint(equalTo: rightAnchor),
         imageView.topAnchor.constraint(equalTo: topAnchor),
         imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
         ]
         }
         
         NSLayoutConstraint.activate(constraints)*/
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "splash"))
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let videoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(pauseVideo)))
        return view
    }()
    
    @objc func pauseVideo() {
        print(pauseVideo)
        player.pause()
    }
    
    @objc func playerDidFinishPlaying() {
        NotificationCenter.default.removeObserver(self)
        print("video finished")
        delegate.slideToNextStory(currentCell: self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchPoint = touch!.location(in: self)
        
        if touchPoint.x > (frame.width / 2) {
            delegate.slideToNextStory(currentCell: self)
        }
        else {
            delegate.slideToPreviousStory(currentCell: self)
        }
    }
}
