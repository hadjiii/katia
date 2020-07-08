//
//  MessageController.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit

private let reuseIdentifier = "messageCell"

class MessageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let messages = ["hello", "hi", "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.", "Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.", "Sed ut lectus porta augue tempor ornare. Nulla vel nisi sit amet lectus rhoncus aliquet. Donec placerat gravida laoreet."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 40, right: 0)
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(controlsContainer)
        controlsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controlsContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerBottomAnchor = controlsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerBottomAnchor?.isActive = true
        containerHeightAnchor = controlsContainer.heightAnchor.constraint(equalToConstant: 41)
        containerHeightAnchor?.isActive = true
        
        controlsContainer.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: controlsContainer.rightAnchor, constant: -10).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor, constant: -10).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        controlsContainer.addSubview(imageButton)
        imageButton.leftAnchor.constraint(equalTo: controlsContainer.leftAnchor, constant: 10).isActive = true
        imageButton.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor, constant: -10).isActive = true
        imageButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        controlsContainer.addSubview(messageTextView)
        messageTextView.leftAnchor.constraint(equalTo: imageButton.rightAnchor, constant: 10).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10).isActive = true
        messageTextView.topAnchor.constraint(equalTo: controlsContainer.topAnchor).isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor).isActive = true
        
        messageTextView.delegate = self
        
        controlsContainer.addSubview(messageFieldIndicator)
        messageFieldIndicator.leftAnchor.constraint(equalTo: imageButton.rightAnchor, constant: 10).isActive = true
        messageFieldIndicator.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10).isActive = true
        messageFieldIndicator.bottomAnchor.constraint(equalTo: messageTextView.bottomAnchor).isActive = true
        messageFieldIndicator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        controlsContainer.addSubview(horizontalSeparator)
        horizontalSeparator.rightAnchor.constraint(equalTo: controlsContainer.rightAnchor).isActive = true
        horizontalSeparator.leftAnchor.constraint(equalTo: controlsContainer.leftAnchor).isActive = true
        horizontalSeparator.topAnchor.constraint(equalTo: controlsContainer.topAnchor).isActive = true
        horizontalSeparator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
        removeKeyboardObservers()
    }
    
    var containerBottomAnchor: NSLayoutConstraint?
    var containerHeightAnchor: NSLayoutConstraint?
    
    let controlsContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        return container
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = .white
        textView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let messageFieldIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "image")?.withTintColor(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return button
    }()
    
    let imageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "image")?.withTintColor(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return button
    }()
    
    let horizontalSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private func estimateFrameFor(text: String, width: CGFloat, height: CGFloat) -> CGRect{
        let size = CGSize(width: width, height: height)
        let drawingOptions = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: drawingOptions, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        let text = messages[indexPath.item]
        let width = estimateFrameFor(text: text, width: 250, height: 300).width + 16
        
        cell.bubbleWidthAnchor?.constant = width
        cell.text.text = text
        
        if indexPath.item % 2 == 0 {
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
            cell.dateRightAnchor?.isActive = true
            cell.dateLeftAnchor?.isActive = false
            cell.date.textAlignment = .right
            cell.bubble.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
            cell.text.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
            cell.destAvatar.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = messages[indexPath.item]
        let height = estimateFrameFor(text: text, width: 250, height: 300).height + 50
        return CGSize(width: collectionView.frame.width, height: height)
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShowNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHideNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleKeyboardWillShowNotification(notification: Notification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        containerBottomAnchor?.constant = -keyboardFrame.height
    }
    
    @objc func handleKeyboardWillHideNotification(notification: Notification) {
        containerBottomAnchor?.constant = 0
    }
}

extension MessageController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width - 90, height: .infinity)
        let estimatedHeight = textView.sizeThatFits(size).height
        let maxHeight: CGFloat = 150
        containerHeightAnchor?.constant = (estimatedHeight > maxHeight ? maxHeight : estimatedHeight) + 20
    }
}
