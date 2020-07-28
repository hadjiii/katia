//
//  MessageController.swift
//  katia
//
//  Created by Hadji on 07/07/2020.
//  Copyright © 2020 Hadji. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "messageCell"
private let controlsContainerMinHeight: CGFloat = 50
private let messageTextViewMinHeight: CGFloat = 30
private let messageMediaViewMaxHeight = 130

class MessageController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var userId: Int? {
        didSet {
            messages = Data.getMessagesWithUserId(userId!)
        }
    }
    var messages = [Message]()
    
    var messageMedia: PHAsset? {
        didSet {
            containerHeightAnchor?.constant = containerHeightAnchor!.constant + 150
            messageMediaViewHeightAnchor?.isActive = true
            imageButtonWidthAnchor?.constant = 0
            messageMediaView.fetchImage(asset: messageMedia!, contentMode: .aspectFit, targetSize: messageMediaView.frame.size)
        }
    }
    
    var userName: String? {
        didSet {
            navigationItem.title = userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 40, right: 0)
        collectionView.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(controlsContainer)
        controlsContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controlsContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerBottomAnchor = controlsContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerBottomAnchor?.isActive = true
        containerHeightAnchor = controlsContainer.heightAnchor.constraint(equalToConstant: controlsContainerMinHeight)
        containerHeightAnchor?.isActive = true
        
        controlsContainer.addSubview(sendButton)
        sendButton.rightAnchor.constraint(equalTo: controlsContainer.rightAnchor, constant: -10).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor, constant: -10).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        controlsContainer.addSubview(imageButton)
        imageButton.leftAnchor.constraint(equalTo: controlsContainer.leftAnchor, constant: 10).isActive = true
        imageButton.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor, constant: -10).isActive = true
        imageButtonWidthAnchor = imageButton.widthAnchor.constraint(equalToConstant: 30)
        imageButtonWidthAnchor?.isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        controlsContainer.addSubview(messageTextAndImageContainer)
        messageTextAndImageContainer.topAnchor.constraint(equalTo: controlsContainer.topAnchor, constant: 10).isActive = true
        messageTextAndImageContainer.bottomAnchor.constraint(equalTo: controlsContainer.bottomAnchor, constant: -10).isActive = true
        messageTextAndImageContainer.leftAnchor.constraint(equalTo: imageButton.rightAnchor, constant: 10).isActive = true
        messageTextAndImageContainer.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: -10).isActive = true
        
        messageTextAndImageContainer.addSubview(messageMediaView)
        messageMediaView.rightAnchor.constraint(equalTo: messageTextAndImageContainer.rightAnchor, constant: -10).isActive = true
        messageMediaView.leftAnchor.constraint(equalTo: messageTextAndImageContainer.leftAnchor, constant: 10).isActive = true
        messageMediaView.topAnchor.constraint(equalTo: messageTextAndImageContainer.topAnchor, constant: 10).isActive = true
        messageMediaViewHeightAnchor = messageMediaView.heightAnchor.constraint(equalToConstant: 130)
        messageMediaViewHeightAnchor?.isActive = false
        
        messageTextAndImageContainer.addSubview(removeMediaButton)
        removeMediaButton.topAnchor.constraint(equalTo: messageTextAndImageContainer.topAnchor, constant: 10).isActive = true
        removeMediaButton.rightAnchor.constraint(equalTo: messageTextAndImageContainer.rightAnchor, constant: -10).isActive = true
        removeMediaButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        removeMediaButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        messageTextAndImageContainer.addSubview(messageTextView)
        messageTextView.leftAnchor.constraint(equalTo: messageTextAndImageContainer.leftAnchor, constant: 0).isActive = true
        messageTextView.rightAnchor.constraint(equalTo: messageTextAndImageContainer.rightAnchor, constant: 0).isActive = true
        messageTextViewHeightAnchor = messageTextView.heightAnchor.constraint(equalToConstant: messageTextViewMinHeight)
        messageTextViewHeightAnchor?.isActive = true
        messageTextView.bottomAnchor.constraint(equalTo: messageTextAndImageContainer.bottomAnchor, constant: 0).isActive = true
        
        messageTextView.delegate = self
        
        controlsContainer.addSubview(horizontalSeparator)
        horizontalSeparator.rightAnchor.constraint(equalTo: controlsContainer.rightAnchor).isActive = true
        horizontalSeparator.leftAnchor.constraint(equalTo: controlsContainer.leftAnchor).isActive = true
        horizontalSeparator.topAnchor.constraint(equalTo: controlsContainer.topAnchor).isActive = true
        horizontalSeparator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        setupKeyboardObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tabBarFrame = tabBarController?.tabBar.frame
        tabBarShadowView.frame = CGRect(x: 0, y: -1, width: (tabBarFrame?.size.width)!, height: 2)
        tabBarController?.tabBar.addSubview(tabBarShadowView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
        tabBarController?.tabBar.willRemoveSubview(tabBarShadowView)
    }
    
    var containerBottomAnchor: NSLayoutConstraint?
    var containerHeightAnchor: NSLayoutConstraint?
    var messageTextViewHeightAnchor: NSLayoutConstraint?
    var messageMediaViewHeightAnchor: NSLayoutConstraint?
    var imageButtonWidthAnchor: NSLayoutConstraint?
    
    let tabBarShadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        return view
    }()
    
    let controlsContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        return container
    }()
    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Start a message"
        textView.textColor = .white
        textView.backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1)
        textView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "normal/send")?.withTintColor(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        button.addTarget(self, action: #selector(sendMessage), for: .touchDown)
        return button
    }()
    
    let imageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "normal/photo")?.withTintColor(UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 36/255, green: 52/255, blue: 71/255, alpha: 1)
        button.addTarget(self, action: #selector(chooseMedia), for: .touchDown)
        return button
    }()
    
    let horizontalSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let messageMediaView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints  = false
        view.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 0.2)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let removeMediaButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1, alpha: 0.5)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(removeMedia), for: .touchUpInside)
        return button
    }()
    
    let messageTextAndImageContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 20/255, green: 29/255, blue: 38/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MessageCell
        let message = messages[indexPath.item]
        let width = estimateFrameFor(text: message.text, width: 250, height: 300).width + 16
        
        cell.bubbleWidthAnchor?.constant = width
        cell.text.text = message.text
        
        if message.senderId == 1 {
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
            cell.dateRightAnchor?.isActive = true
            cell.dateLeftAnchor?.isActive = false
            cell.date.textAlignment = .right
            cell.bubble.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
            cell.text.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
            cell.destAvatar.isHidden = true
        }
        else {
            cell.bubbleRightAnchor?.isActive = false
            cell.bubbleLeftAnchor?.isActive = true
            cell.dateRightAnchor?.isActive = false
            cell.dateLeftAnchor?.isActive = true
            cell.date.textAlignment = .left
            cell.bubble.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
            cell.text.backgroundColor = UIColor(red: 101/255, green: 119/255, blue: 134/255, alpha: 1)
            cell.destAvatar.isHidden = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = messages[indexPath.item].text
        let height = estimateFrameFor(text: text, width: 250, height: 300).height + 50
        return CGSize(width: collectionView.frame.width, height: height)
    }
}

extension MessageController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width - 90, height: .infinity)
        let estimatedHeight = textView.sizeThatFits(size).height
        let maxHeight: CGFloat = 150
        let containerHeight = (estimatedHeight > maxHeight ? maxHeight : estimatedHeight) + 20
        containerHeightAnchor?.constant = (messageMediaViewHeightAnchor!.isActive ? containerHeight + 130 : containerHeight)
        messageTextViewHeightAnchor!.constant = containerHeight - 20
    }
}

extension MessageController {
    private func estimateFrameFor(text: String, width: CGFloat, height: CGFloat) -> CGRect{
        let size = CGSize(width: width, height: height)
        let drawingOptions = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: drawingOptions, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
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
    
    @objc func sendMessage() {
        if let messageText = messageTextView.text {
            if messageText.isEmpty {
                return
            }
            
            guard let userId = userId else { return }
            
            let message = Message(id: 11, senderId: 1, recipientId: userId, text: messageText, date: "today")
            Data.addMessage(message)
            messages = Data.getMessagesWithUserId(userId)
            let item = messages.count - 1
            collectionView.insertItems(at: [IndexPath(item: item, section: 0)])
            collectionView.scrollToItem(at: IndexPath(item: item, section: 0), at: .bottom, animated: true)
            messageTextView.text = nil
            textViewDidChange(messageTextView)
        }
    }
    
    @objc func chooseMedia() {
        let layout = UICollectionViewFlowLayout()
        let messageMediaController = MessageMediaController(collectionViewLayout: layout)
        messageMediaController.messageController = self
        navigationController?.pushViewController(messageMediaController, animated: true)
    }
    
    func showMessageMedia() {
        
    }
    
    @objc func removeMedia() {
        let size = CGSize(width: view.frame.width - 90, height: .infinity)
        let estimatedHeight = messageTextView.sizeThatFits(size).height
        let maxHeight: CGFloat = 150
        let containerHeight = (estimatedHeight > maxHeight ? maxHeight : estimatedHeight) + 20
        containerHeightAnchor?.constant = containerHeight
        messageTextViewHeightAnchor!.constant = containerHeight - 20
        messageMediaViewHeightAnchor?.isActive = false
        imageButtonWidthAnchor?.constant = 20
    }
}
