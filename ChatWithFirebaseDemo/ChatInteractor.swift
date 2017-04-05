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
    private(set) lazy var chRef = FIRDatabase.database().reference().child("channels")
    private var newMessageRefHandle: FIRDatabaseHandle?
    private let messageChild = "messages"
    
    // MARK: Function
    func FIRStoreMessage(cannelId: String, sendId: String,
                         sendName: String, text: String) {
        let ref = chRef.child(cannelId).child(messageChild).childByAutoId()
        let messageItem = ["senderId": sendId,
                           "senderName": sendName,
                           "text": text]
        ref.setValue(messageItem)
    }
    
    func FIRObserveMessages(cannelId: String,
                            complete: @escaping ([String:String]) -> (),
                            fail: @escaping () -> ()) {
        let ref = chRef.child(cannelId).child(messageChild)
        let messageQuery = ref.queryLimited(toLast:25)
        
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            let messageData = snapshot.value as! Dictionary<String, String>
            if let _ = messageData["senderId"] as String!,
                let _ = messageData["senderName"] as String!,
                let text = messageData["text"] as String!,
                text.characters.count > 0 {
                complete(messageData)
            } else {
                fail()
            }
        })
    }
}
