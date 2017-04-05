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
    private let interactor = ChatInteractor()
    private(set) var messages = [JSQMessage]()
    
    // MARK: Function
    func addMessage(message: JSQMessage) {
        messages.append(message)
    }
    
    func pressSend(chId: String, sendId: String, sendName: String, text: String) {
        interactor.FIRStoreMessage(cannelId: chId,
                                   sendId: sendId,
                                   sendName: sendName,
                                   text: text)
    }
    
    // Collection View
    func numberOfItemsInSection() -> Int {
        return messages.count
    }
    
    func messageDataForItem(row: Int) -> JSQMessageData {
        return messages[row]
    }
    
}
