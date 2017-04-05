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
    let viewModel = ChannelsListViewModel()
    let channelCellIdentifier = "ChannelCell"
    
    // MARK: = Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configureDelegate(delegate: self)
        viewModel.observeChannels()
    }
    
    deinit {
        viewModel.removeObserveChannels()
    }
    
    // MARK: - IBAction
    @IBAction func createChannel() {
        viewModel.createChannel()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ChannelsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: channelCellIdentifier,
                                                 for: indexPath)
        cell.textLabel?.text = viewModel.channelData(row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ChannelsListViewModelDelegate
extension ChannelsListViewController: ChannelsListViewModelDelegate {
    func ObserveChannelSuccess() {
        tableView.reloadData()
    }
}
