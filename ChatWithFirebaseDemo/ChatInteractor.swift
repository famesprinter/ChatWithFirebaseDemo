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
    private(set) lazy var messageRef = FIRDatabase.database().reference().child("channels").child("messages")
    private var newMessageRefHandle: FIRDatabaseHandle?
    
    // MARK: Function
    
    
}
