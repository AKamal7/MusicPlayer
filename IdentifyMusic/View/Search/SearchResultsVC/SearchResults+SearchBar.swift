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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.offset = 0
            guard !searchText.isEmpty else {
                return
               

            }
        setupSearchResults()
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
        cider.song(id: <#T##String#>, completion: <#T##((Track?, Error?) -> Void)?#>)
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
    
    
    
}
