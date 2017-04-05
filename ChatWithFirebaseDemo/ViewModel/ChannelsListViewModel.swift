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
    var channels = [Channel]()
    
    // MARK: - Function
    func channelData(row: Int) -> String {
        return channels[row].name
    }
    
    // API
    func observeChannels() {
        interactor.FIRObserveChannels(complete: { (snapshot: FIRDataSnapshot) in
                                        let channelData = snapshot.value as! [String:AnyObject]
                                        let id = snapshot.key
                                        self.channels.append(Channel(id: id,
                                                                     name: channelData["name"] as! String))
        },
                                      fail: { () in
                                        print("Error! Could not decode channel data")
        })
    }
    
    // Table View
    func numberOfRow() -> Int {
        return channels.count
    }
}
