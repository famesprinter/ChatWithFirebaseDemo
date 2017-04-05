//
//  ChannelsListInteractor.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 4/5/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import Foundation
import Firebase

class ChannelsListInteractor {
    // MARK: - Variable
    private(set) lazy var channelRef = FIRDatabase.database().reference().child("channels")
    private let FIRChild = "channels"
    private var channelRefHandle: FIRDatabaseHandle?

    // MARK: - Function
    func FIRCreateChannel(cName: String) {
        let newChannelRef = channelRef.childByAutoId()
        let channelItem = ["name": cName]
        newChannelRef.setValue(channelItem)
    }
    
    func FIRObserveChannels(complete: @escaping (FIRDataSnapshot) -> (),
                            fail: @escaping () -> ()) {
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            if let name = channelData["name"] as! String!, name.characters.count > 0 {
                complete(snapshot)
            } else {
                fail()
            }
        })
    }
    
    func FIRRemoveObserveChannels(complete: @escaping () -> (),
                                  fail: @escaping () -> ()) {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
            complete()
        } else {
            fail()
        }
    }
}
