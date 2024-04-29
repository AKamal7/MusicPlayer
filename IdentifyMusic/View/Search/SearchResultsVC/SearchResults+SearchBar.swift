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
        cider.search(term: searchBar.text ?? "",limit: 5, types: [.songs]) { results, error in
            print(error?.localizedDescription, "ErRRRrror")
            
            if let songs = results?.songs?.data {
                self.songsData = songs
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(songs, "DATAA")
            }
            
            //            }
        }
    }
}
