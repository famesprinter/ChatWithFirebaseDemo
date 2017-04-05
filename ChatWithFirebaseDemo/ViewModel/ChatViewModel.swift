//
//  ChatViewModel.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 4/5/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import Foundation
import JSQMessagesViewController

class ChatViewModel {
    // MARK: Variable
    private weak var delegate: ChatViewModelDelegate?
    private let interactor = ChatInteractor()
    private(set) var messages = [JSQMessage]()
    
    // MARK: Function
    func configureDelegate(delegate: ChatViewModelDelegate) {
        self.delegate = delegate
    }
    
    func addMessage(message: JSQMessage) {
        messages.append(message)
    }
    
    func pressSend(chId: String, sendId: String, sendName: String, text: String) {
        interactor.FIRStoreMessage(cannelId: chId,
                                   sendId: sendId,
                                   sendName: sendName,
                                   text: text)
    }
    
    // API
    func observeMessages(chId: String) {
        interactor.FIRObserveMessages(cannelId: chId,
                                      complete: { (messageData: [String:String]) in
                                        let id = messageData["senderId"]
                                        let name = messageData["senderName"]
                                        let text = messageData["text"]
        },
                                      fail: { () in
                                        print("Error! Could not decode message data")
        })
    }
    
    // Collection View
    func numberOfItemsInSection() -> Int {
        return messages.count
    }
    
    func messageDataForItem(row: Int) -> JSQMessageData {
        return messages[row]
    }
    
}
