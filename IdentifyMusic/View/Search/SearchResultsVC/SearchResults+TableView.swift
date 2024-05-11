//
//  SearchResults+TableView.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/04/2024.
//

import Foundation
import UIKit
import Cider

extension SearchResultsVC: UITableViewDelegate, UITableViewDataSource {
    
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
        if UserDefaultsManager.shared().youtubeEnabled ?? false {
            return self.youtubeVid.count
        } else {
            if let data = songsData?.data {
                return data.count
            } else {
                return 0
            }
        }
        
        //return songsData.data?.count ?? 0
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
        cell.cellImgView.roundCorners(corners: .allCorners, radius: 32.5)
        cell.containerView.roundCorners(topLeft: 40,topRight: 12, bottomLeft: 40, bottomRight: 12)
        cell.selectionStyle = .none
        if UserDefaultsManager.shared().youtubeEnabled == true {
            cell.setupYoutube(model: youtubeVid[indexPath.row])
        } else {
            guard let songs = songsData?.data else { return UITableViewCell() }
            cell.songNameLabel.text = songs[indexPath.row].attributes?.name
            cell.artistNameLabel.text = songs[indexPath.row].attributes?.artistName
            cell.dateLabel.isHidden = true
            cell.setupCell(model: songs[indexPath.row])
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if UserDefaultsManager.shared().youtubeEnabled == true {
           
        } else {
            if let data = songsData?.data {
                print("11111111", isPagination)
                if indexPath.row == data.count - 2 {
                    print("22222222", isPagination)
                    if isPagination {
                        print("33333333")
                        self.loadMoreResults(offset: self.offset)
                    }
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ay 7aga")
        let player = UIStoryboard(name: "PlayerVC", bundle: nil).instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
        if UserDefaultsManager.shared().youtubeEnabled == true {
            player.videoID = youtubeVid[indexPath.row].videoId
            player.youtubeVid = youtubeVid[indexPath.row]
        } else {
            guard let songs = songsData?.data else { return }
            nowPlayingTrack = songs[indexPath.row]
            player.songData = songs[indexPath.row]
        }
        
        navigationController?.pushViewController(player, animated: false)
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122
    }
    
    
    
    
}
