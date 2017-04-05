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
    // MARK: - Function
    func FIRObserveChannels(complete: @escaping (FIRDataSnapshot) -> (),
                            fail: @escaping () -> ()) {
        let channelRef = FIRDatabase.database().reference().child("channels")
        channelRef.observe(.childAdded, with: { (snapshot) -> Void in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            if let name = channelData["name"] as! String!, name.characters.count > 0 {
                complete(snapshot)
            } else {
                fail()
            }
        })
    }
}