//
//  MessageCell.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit
import Photos

class MessageCell: UICollectionViewCell {
    var message: Message? {
        didSet {
            self.downloadMedia()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(destAvatar)
        destAvatar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        destAvatar.widthAnchor.constraint(equalToConstant: 40).isActive = true
        destAvatar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        destAvatar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
        
        addSubview(mediaView)
        mediaViewLeftConstraint = mediaView.leftAnchor.constraint(equalTo: destAvatar.rightAnchor, constant: 10)
        mediaViewLeftConstraint?.isActive = true
        mediaViewRightConstraint = mediaView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        mediaViewRightConstraint?.isActive = false
        mediaView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        mediaView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        mediaViewHeightShowConstraint = mediaView.heightAnchor.constraint(lessThanOrEqualToConstant: 200)
        mediaViewHeightShowConstraint?.isActive = true
        mediaViewHeightHideConstraint = mediaView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0)
        mediaViewHeightHideConstraint?.isActive = false
        
        addSubview(bubble)
        bubbleLeftAnchor =  bubble.leftAnchor.constraint(equalTo: destAvatar.rightAnchor, constant: 10)
        bubbleLeftAnchor?.isActive = true
        bubbleRightAnchor =  bubble.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        bubbleRightAnchor?.isActive = false
        bubbleWidthAnchor = bubble.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubble.topAnchor.constraint(equalTo: mediaView.bottomAnchor, constant: 0).isActive = true
        bubble.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
        bubble.addSubview(text)
        text.leftAnchor.constraint(equalTo: bubble.leftAnchor).isActive = true
        text.rightAnchor.constraint(equalTo: bubble.rightAnchor).isActive = true
        text.topAnchor.constraint(equalTo: bubble.topAnchor).isActive = true
        text.bottomAnchor.constraint(equalTo: bubble.bottomAnchor).isActive = true
        
        addSubview(date)
        dateLeftAnchor =  date.leftAnchor.constraint(equalTo: destAvatar.rightAnchor, constant: 10)
        dateLeftAnchor?.isActive = true
        dateRightAnchor =  date.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        dateRightAnchor?.isActive = false
        date.widthAnchor.constraint(equalToConstant: 200).isActive = true
        date.topAnchor.constraint(equalTo: bubble.bottomAnchor, constant: 10).isActive = true
        date.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var isCurrentUserMessage: Bool = false
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleLeftAnchor: NSLayoutConstraint?
    var bubbleRightAnchor: NSLayoutConstraint?
    var dateLeftAnchor: NSLayoutConstraint?
    var dateRightAnchor: NSLayoutConstraint?
    var mediaViewLeftConstraint: NSLayoutConstraint?
    var mediaViewRightConstraint: NSLayoutConstraint?
    var mediaViewHeightShowConstraint: NSLayoutConstraint?
    var mediaViewHeightHideConstraint: NSLayoutConstraint?
    
    let destAvatar: UIImageView = {
        let avatar = UIImageView(image: UIImage(named: "normal/user"))
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.backgroundColor = .lightGray
        avatar.layer.cornerRadius = 20
        avatar.layer.masksToBounds = true
        return avatar
    }()
    
    let bubble: UIView = {
        let msg = UIView()
        msg.translatesAutoresizingMaskIntoConstraints = false
        msg.backgroundColor = UIColor(red: 61/255, green: 84/255, blue: 102/255, alpha: 1)
        msg.layer.cornerRadius = 10
        msg.layer.masksToBounds = true
        return msg
    }()
    
    let text: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    lazy var date: UILabel = {
        let dt = UILabel()
        dt.text = "Saturday, 19 AM"
        dt.textColor = UIColor(red: 61/255, green: 84/255, blue: 102/255, alpha: 1)
        dt.translatesAutoresizingMaskIntoConstraints = false
        return dt
    }()
    
    let mediaView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private func downloadMedia() {
        if message?.mediaType == MediaType.image {
            guard let mediaLink = message?.mediaLink else {return}
            guard let url = URL(string: mediaLink) else {return}
            
            URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error downloading cat picture: \(error)")
                    return
                }
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.mediaView.image = image
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }.resume()
        }
        else if message?.mediaType == MediaType.video {
            guard let mediaLink = message?.mediaLink else {return}
            guard let url = URL(string: mediaLink) else {return}
            
            let asset = AVAsset(url: url)
            let assetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImageGenerator.appliesPreferredTrackTransform = true
            
            let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
            
            do {
                let image = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: image)
                DispatchQueue.main.async {
                    self.mediaView.image = thumbnail
                }
            }
            catch {
                print(error)
            }
        }
    }
}
