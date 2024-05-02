
//
//  PlistVC + TableView.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 19/3/2024.
//

import Foundation
import UIKit



extension MusicTableVC: UITableViewDelegate, UITableViewDataSource {
    

   
    // Register TableView Cell
    func registerCell() {
        tableView.register(UINib(nibName: "HistoryTableCell", bundle: nil), forCellReuseIdentifier: "HistoryTableCell")
    }
    
    // Setting up tableView
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.mainBackground
        registerCell()
    }
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tracks = playlist?.relationships?.tracks.data {
            return tracks.count
        } else {
            return 0
        }
    }
    
    // Config cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableCell", for: indexPath) as? HistoryTableCell else {
            return UITableViewCell()
        }
        
        // Config cell
        cell.backgroundColor = UIColor(hex: "141414", alpha: 1)
        cell.clipsToBounds = true
        cell.containerView.backgroundColor = UIColor(hex: "1f1f1f")
//        cell.containerView.roundCorners(corners: [.topRight, .bottomRight], radius: 100)
//        cell.containerView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 51)
        cell.cellImgView.roundCorners(corners: .allCorners, radius: 32.5)
        cell.containerView.roundCorners(topLeft: 40,topRight: 12, bottomLeft: 40, bottomRight: 12)
        cell.containerView.clipsToBounds = true
        cell.selectionStyle = .none
        cell.songNameLabel.text = playlist?.relationships?.tracks.data?[indexPath.row].attributes?.name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ay 7aga")
        let player = UIStoryboard(name: "PlayerVC", bundle: nil).instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
        
        player.songData = playlist?.relationships?.tracks.data?[indexPath.row]
        navigationController?.pushViewController(player, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    
    
    
}
