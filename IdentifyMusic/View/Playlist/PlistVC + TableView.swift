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
import MusadoraKit

extension PlaylistVC: UITableViewDelegate, UITableViewDataSource {
    
    
   
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
        return playlistsData.count  
    }
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
        
        for play in playlistsData {
            cell.PlistNameLbl.text = play.attributes?.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ay 7aga")
        let vc = UIStoryboard(name: "MusicTableVC", bundle: nil).instantiateViewController(withIdentifier: "MusicTableVC") as! MusicTableVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
    func authenticateUser(completion: @escaping (String?, Error?) -> Void) {
        // Present the SKCloudServiceSetupViewController to the user for authorization
        SKCloudServiceController.requestAuthorization { status in
            switch status {
            case .authorized:
                // Authorization successful
                // Now, obtain the user token
                SKCloudServiceController().requestUserToken(forDeveloperToken: UserDefaultsManager.shared().token ?? "") { userToken, error in
                    if let userToken = userToken {
                        // Authentication successful, pass user token and nil error
                        print("flagToke", userToken)
                        completion(userToken, nil)
                    } else {
                        
                        // Unable to obtain user token, pass error
                        completion(nil, error ?? NSError(domain: "MusicManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to obtain user token"]))
                    }
                }
            case .denied, .restricted:
                // Authorization denied or restricted, indicate error
                completion(nil, NSError(domain: "MusicManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Authorization denied or restricted"]))
            case .notDetermined:
                // Authorization not determined yet, handle as needed
                completion(nil, NSError(domain: "MusicManager", code: 2, userInfo: [NSLocalizedDescriptionKey: "Authorization not determined"]))
            @unknown default:
                // Unknown case, handle as needed
                completion(nil, NSError(domain: "MusicManager", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unknown authorization status"]))
            }
        }
    }
    
    // Function to fetch user playlists using the obtained user token
    
//    func fetchUserPlaylists(userToken: String, completion: @escaping ([String]?, Error?) -> Void) {
//        // Construct the request to fetch user playlists using the user token
//        let baseURL = "https://api.music.apple.com"
//        let url = URL(string: "\(baseURL)/v1/me/library/playlists")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: "Authorization")
//        request.addValue("\(userToken)", forHTTPHeaderField: "Music-User-Token")
//        
//        // Perform the request
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            // Check for any errors
//            if let error = error {
//                completion(nil, error)
//                return
//            }
//            
//            // Parse the response data
//            guard let data = data else {
//                completion(nil, NSError(domain: "MusicManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"]))
//                return
//            }
//            
//            do {
//                // Decode the JSON response
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                if let playlistsData = json?["data"] as? [[String: Any]] {
//                    // Extract playlist names from the response
//                    let playlistNames = playlistsData.compactMap { $0["attributes"] as? [String: Any] } .compactMap { $0["name"] as? String }
//                    completion(playlistNames, nil)
//                } else {
//                    // Unable to parse playlists data
//                    completion(nil, NSError(domain: "MusicManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error parsing playlists data"]))
//                }
//            } catch {
//                // Error decoding JSON
//                completion(nil, error)
//            }
//        }.resume()
//    }


    func fetchMyPlaylists(userToken: String, completion: @escaping ([Playlist]?, Error?) -> Void) {
        let baseURL = "https://api.music.apple.com"
        let endpoint = "/v1/me/library/playlists"
        let url = URL(string: "\(baseURL)\(endpoint)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("\(userToken)", forHTTPHeaderField: "Music-User-Token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error ?? NSError(domain: "MusicManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"]))
                return
            }
            
            do {
                let playlistResponse = try JSONDecoder().decode(PlaylistResponse.self, from: data)
                completion(playlistResponse.data, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }

    
    
    
}
