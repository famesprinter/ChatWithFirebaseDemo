//
//  ChatViewController.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 4/5/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    // MARK: Variable
    let viewModel = ChatViewModel()
    var channel: Channel? {
        didSet {
            title = channel?.name
        }
    }
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configureDelegate(delegate: self)
        senderDisplayName = "FameSprinteR"
        senderId = viewModel.context.uID()
        viewModel.observeMessages(chId: (channel?.id)!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Function
    func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            viewModel.addMessage(message: message)
        }
    }
    
    // MARK: Collection View
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return viewModel.messageDataForItem(row: indexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = viewModel.messageDataForItem(row: indexPath.item)
        if message.senderId() == senderId {
            return outgoingBubbleImageView
        } else {
            return incomingBubbleImageView
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        let image = UIImage(named: "Avatar.png")
        let avatarImg = JSQMessagesAvatarImage.avatar(with: image)
        avatarImg?.avatarImage = JSQMessagesAvatarImageFactory.circularAvatarImage(image!,withDiameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        return avatarImg
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = viewModel.messageDataForItem(row: indexPath.item)
        
        if message.senderId() == senderId {
            cell.textView?.textColor = UIColor.white
        } else {
            cell.textView?.textColor = UIColor.black
        }
        return cell
    }
    
    // MARK: JSQDelegate
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        viewModel.pressSend(chId: (channel?.id)!,
                            sendId: senderId,
                            sendName: senderDisplayName,
                            text: text)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
    }
}

// MARK: ChatViewModelDelegate
extension ChatViewController: ChatViewModelDelegate {
    func observeMessageSuccess(id: String, name: String, text: String) {
        addMessage(withId: id, name: name, text: text)
        finishReceivingMessage()
    }
}
