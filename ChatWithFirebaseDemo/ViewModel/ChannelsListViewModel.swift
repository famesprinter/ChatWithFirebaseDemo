//
//  ChannelsListViewModel.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 3/10/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import Foundation
import Firebase

class ChannelsListViewModel {
    // MARK: - Variable
    let context = Context.context
    let interactor = ChannelsListInteractor()
    
    // MARK: - Function
    // API
    func observeChannels() {
        interactor.FIRObserveChannels(complete: { (snapshot: FIRDataSnapshot) in
                                        let channelData = snapshot.value as! [String:AnyObject]
                                        let id = snapshot.key
        },
                                      fail: { () in
                                        print("Error! Could not decode channel data")
        })
    }
    
}
