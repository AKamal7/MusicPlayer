//
//  HistoryVC+SearchBar.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 03/04/2024.
//

import Foundation

import UIKit

extension HistoryVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
                return
            }
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
        searchBar.setImage(UIImage(named: "ph_magnifying-glass"), for: .search, state: .normal)
    }
}
