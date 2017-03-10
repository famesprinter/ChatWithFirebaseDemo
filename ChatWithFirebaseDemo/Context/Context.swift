//
//  Context.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 3/10/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import Foundation

class Context {
    static let context = Context()
    
    // MARK: - Variable
    private var userID = ""
    
    // MARK: - Function
    func updateUserID(uID: String) {
        userID = uID
    }
    
    func uID() -> String {
        return userID
    }
}
