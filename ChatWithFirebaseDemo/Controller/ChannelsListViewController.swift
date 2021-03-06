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
    let showChannelIdentifier = "ShowChannel"
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.configureDelegate(delegate: self)
        viewModel.observeChannels()
    }
    
    deinit {
        viewModel.removeObserveChannels()
    }
    
    // MARK: prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let vc = segue.destination as! ChatViewController
            vc.channel = channel
        }
    }
    
    // MARK: IBAction
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
        
        let channel = viewModel.channels[indexPath.row]
        performSegue(withIdentifier: showChannelIdentifier, sender: channel)
    }
}

// MARK: - ChannelsListViewModelDelegate
extension ChannelsListViewController: ChannelsListViewModelDelegate {
    func observeChannelSuccess() {
        tableView.reloadData()
    }
}
