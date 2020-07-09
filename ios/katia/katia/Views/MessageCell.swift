//
//  MessageCell.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(destAvatar)
        destAvatar.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        destAvatar.widthAnchor.constraint(equalToConstant: 40).isActive = true
        destAvatar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        destAvatar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30).isActive = true
        
        addSubview(bubble)
        bubbleLeftAnchor =  bubble.leftAnchor.constraint(equalTo: destAvatar.rightAnchor, constant: 10)
        bubbleLeftAnchor?.isActive = true
        bubbleRightAnchor =  bubble.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        bubbleRightAnchor?.isActive = false
        bubbleWidthAnchor = bubble.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubble.heightAnchor.constraint(equalTo: heightAnchor, constant: -30).isActive = true
        
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
        msg.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
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
        dt.textColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        dt.translatesAutoresizingMaskIntoConstraints = false
        return dt
    }()
}
