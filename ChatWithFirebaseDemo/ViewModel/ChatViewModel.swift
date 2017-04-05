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
    private(set) var messages = [JSQMessage]()
    
    // MARK: Function
    func addMessage(message: JSQMessage) {
        messages.append(message)
    }
    
    // Collection View
    func numberOfItemsInSection() -> Int {
        return messages.count
    }
    
    func messageDataForItem(row: Int) -> JSQMessageData {
        return messages[row]
    }
    
}
