//
//  PlistVC + TableView.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 19/3/2024.
//

import Foundation
import UIKit
import MediaPlayer
import Cider
import CupertinoJWT
import StoreKit

extension PlaylistVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func getData() {
        let p8 = """
            -----BEGIN PRIVATE KEY-----
            MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQg1rLpjJ1IxyLHl1dl
            oo3IKO9x1Wv/4msdMXXll5nhhIigCgYIKoZIzj0DAQehRANCAATkIJJnP6Tfabtd
            MXlkfJqAVeKGfQ0pAe3FIbxjdYgHfEBp4q+oCGklkBcHnYZO1XfzwW82xntW6bkU
            0wWARvaV
            -----END PRIVATE KEY-----
            """
        

        let jwt = JWT(keyID: "SQ9L7MVJ9R", teamID: "ZHXVY6M87Z", issueDate: Date(), expireDuration: 60 * 60)

        do {
            let token = try jwt.sign(with: p8)
            print(token, "tokeeen")
            let cider = CiderClient(storefront: .unitedStates, developerToken: token)
            cider.search(term: "Michael Jackson", types: [.songs]) { results, error in
                print(error?.localizedDescription, "Errror")
//                print(results, "resultsss")
                if let playlists = results?.songs?.data {
                    self.playlistsData = playlists
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                   
                    
                }
            }
        } catch {
            print(error)
        }
    }
   
    // Register TableView Cell
    func registerCell() {
        tableView.register(UINib(nibName: "PlistTableCell", bundle: nil), forCellReuseIdentifier: "PlistTableCell")
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
        return playlistsData.count    }
    // Config cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlistTableCell", for: indexPath) as? PlistTableCell else {
            return UITableViewCell()
        }
        
     
        
        
        
        
        
        // Config cell
        cell.backgroundColor = UIColor(hex: "141414", alpha: 1)
        cell.clipsToBounds = true
        cell.containerView.backgroundColor = UIColor(hex: "1f1f1f")
        cell.containerView.layer.cornerRadius = 12
        cell.selectionStyle = .none
        cell.delegate = self
        
        cell.PlistNameLbl.text = playlistsData[indexPath.row].attributes?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ay 7aga")
        let vc = UIStoryboard(name: "MusicTableVC", bundle: nil).instantiateViewController(withIdentifier: "MusicTableVC") as! MusicTableVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
