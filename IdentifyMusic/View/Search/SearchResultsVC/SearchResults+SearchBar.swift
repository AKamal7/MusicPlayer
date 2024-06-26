//
//  SearchResults+SearchBar.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/04/2024.
//

import Foundation
import UIKit
import Cider

extension SearchResultsVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.offset = 0
        guard let searchText = searchBar.searchTextField.text else { return }
        guard !searchText.isEmpty else {
            return
        }
        
        if UserDefaultsManager.shared().youtubeEnabled ?? false {
            searchYouTube(searchText: searchText)
        } else {
            setupSearchResults()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        self.offset = 0
//            guard !searchText.isEmpty else {
//                return
//            }
//        
//        if UserDefaultsManager.shared().youtubeEnabled ?? false {
//            searchYouTube(searchText: searchText)
//        } else {
//            setupSearchResults()
//        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 15, vertical: 0)
        searchBar.searchTextField.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0)
        searchBar.searchTextField.textColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.frame = CGRect(x: 0, y: 0, width: 382, height: 45)
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = Colors.searchBarColor.cgColor
        searchBar.searchTextField.layer.cornerRadius = 12
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search by name or artist...",
            attributes: [.foregroundColor: UIColor.gray]
        )
        searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    
    func setupSearchResults() {
        
        let cider = CiderClient(storefront: .egypt, developerToken: UserDefaultsManager.shared().token ?? "")
        cider.search(term: searchBar.text ?? "", limit: 25, offset: self.offset, types: [.songs]) { results, error in
            //print(error?.localizedDescription, "ErRRRrror")
            
            if let songs = results?.songs {
                self.songsData = songs
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                if songs.next != nil {
                    self.isPagination = true
                    guard let next = songs.next else { return }
                    guard let offsetServer = self.getQueryStringParameter(url: next, param: "offset") else { return }
                    self.offset = Int(offsetServer) ?? 0
                } else {
                    self.isPagination = false
                }
            }
        }
    }
    
    func loadMoreResults(offset: Int) {
        
        let cider = CiderClient(storefront: .egypt, developerToken: UserDefaultsManager.shared().token ?? "")
        cider.search(term: searchBar.text ?? "", limit: 25, offset: offset, types: [.songs]) { results, error in
            //print(error?.localizedDescription, "ErRRRrror")
            print("calleeeeeeed")
            if let songs = results?.songs {
                if let data = songs.data {
                    self.songsData?.data! += data
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    print("we are here for more")
                }
                
                if songs.next != nil {
                    self.isPagination = true
                    guard let next = songs.next else { return }
                    guard let offsetServer = self.getQueryStringParameter(url: next, param: "offset") else { return }
                    self.offset = Int(offsetServer) ?? 0
                } else {
                    self.isPagination = false
                    print(self.songsData?.data?.count ?? 0, "count")
                }
               
                print(songs, "DATAA")
            }
        }
    }
    
    func getQueryStringParameter(url: String, param: String) -> String? {
      guard let url = URLComponents(string: url) else { return nil }
      return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    func searchYouTube(searchText: String) {
        searchYouTubeVideos(query: searchText) { (videos, error) in
            if let error = error {
                // Handle the error
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let videos = videos {
                self.youtubeVid = videos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
    func searchYouTubeVideos(query: String, completion: @escaping ([Video]?, Error?) -> Void) {
        // Construct the URL
        let urlString = "https://www.googleapis.com/youtube/v3/search"

        // Construct the query parameters
        let apiKey = "AIzaSyD_53VTrGxEDO2-oCi6g7HVQXYAaOVtnyI"
        let part = "snippet"
        let order = "rating" // Specify the desired order, e.g., relevance, date, rating, etc.
    
        let queryParams: [String: String] = [
            "part": part,
            "q": query,
            "key": apiKey,
            "order": order,
            "maxResults": "50"
        ]

        // Create the URL components
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }

        // Make the GET request
        guard let url = urlComponents?.url else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            if let data = data {
                // Parse the response data
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                    // Process the JSON and extract the video information
                    // Example implementation:
                    var videos: [Video] = []

                    if let items = json?["items"] as? [[String: Any]] {
                        for item in items {
                            if let itemId = item["id"] as? [String: Any],
                               let videoId = itemId["videoId"] as? String,
                               let snippet = item["snippet"] as? [String: Any],
                               let title = snippet["title"] as? String,
                               let thumbnails = snippet["thumbnails"] as? [String: Any],
                               let defaultThumbnail = thumbnails["default"] as? [String: Any],
                               let channelTitle = snippet["channelTitle"] as? String,
                               let thumbnailUrl = defaultThumbnail["url"] as? String {

                                let video = Video(videoId: videoId, title: title, thumbnailUrl: thumbnailUrl, channelTitle: channelTitle)
                                videos.append(video)
                            }
                        }
                        completion(videos, nil)
                    } else {
                        completion(nil, error)
                    }

                    
                } catch {
                    completion(nil, error)
                }
            } else {
                completion(nil, NSError(domain: "No data returned", code: 0, userInfo: nil))
            }
        }.resume()
    }
    
}
