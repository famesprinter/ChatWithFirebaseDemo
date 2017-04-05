//
//  ChatViewController.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 4/5/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    // MARK: - Variable
    var channel: Channel? {
        didSet {
            title = channel?.name
        }
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        senderDisplayName = "FameSprinteR"
        senderId = channel?.id
    }
}
