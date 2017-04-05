//
//  ChatViewModelDelegate.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 4/5/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import Foundation

protocol ChatViewModelDelegate: class {
    func observeMessageSuccess(id: String, name: String, text: String)
}
