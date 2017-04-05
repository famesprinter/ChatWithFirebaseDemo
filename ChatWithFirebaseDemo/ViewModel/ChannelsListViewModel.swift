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
    private weak var delegate: ChannelsListViewModelDelegate?
    let context = Context.context
    let interactor = ChannelsListInteractor()
    private(set) var channels = [Channel]()
    
    // MARK: - Function
    func configureDelegate(delegate: ChannelsListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func channelData(row: Int) -> String {
        return channels[row].name
    }
    
    // API
    func createChannel() {
        interactor.FIRCreateChannel(cName: "Channel \(channels.count+1)")
    }
    
    func observeChannels() {
        interactor.FIRObserveChannels(complete: { (snapshot: FIRDataSnapshot) in
                                        let channelData = snapshot.value as! [String:AnyObject]
                                        let id = snapshot.key
                                        self.channels.append(Channel(id: id,
                                                                     name: channelData["name"] as! String))
                                        self.delegate?.observeChannelSuccess()
        },
                                      fail: { () in
                                        print("Error! Could not decode channel data")
        })
    }
    
    func removeObserveChannels() {
        interactor.FIRRemoveObserveChannels(complete: { () in
                                                print("Remove Success!!")
        },
                                            fail: { () in
                                                print("Not observe!!")
        })
    }
    
    // Table View
    func numberOfRow() -> Int {
        return channels.count
    }
}
