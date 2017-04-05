//
//  ChatInteractor.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 4/5/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import Foundation
import Firebase

class ChatInteractor {
    // MARK: Variable
    private(set) lazy var messageRef = FIRDatabase.database().reference().child("channels")
    private var newMessageRefHandle: FIRDatabaseHandle?
    private let messageChild = "messages"
    
    // MARK: Function
    func FIRStoreMessage(cannelId: String, sendId: String,
                         sendName: String, text: String) {
        let itemRef = messageRef.child(cannelId).child(messageChild).childByAutoId()
        let messageItem = ["senderId": sendId,
                           "senderName": sendName,
                           "text": text]
        itemRef.setValue(messageItem)
    }
}
