//
//  ChannelsListViewController.swift
//  ChatWithFirebaseDemo
//
//  Created by Kittitat Rodphotong on 3/10/2560 BE.
//  Copyright © 2560 FameSprinter. All rights reserved.
//

import UIKit

class ChannelsListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    
    
    // MARK: = Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ChannelsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
