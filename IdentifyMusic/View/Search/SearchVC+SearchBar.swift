//
//  SearchVC+SearchBar.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 1/4/2024.
//

import Foundation
import UIKit

extension SearchVC: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
                return
            }
        }
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.setImage(UIImage(named: "ph_magnifying-glass"), for: .search, state: .normal)
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        searchBar.searchTextField.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0)
        searchBar.searchTextField.textColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.frame = CGRect(x: 0, y: 0, width: 195, height: 45)
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = Colors.searchBarColor.cgColor
        searchBar.searchTextField.layer.cornerRadius = 12
        searchBar.searchTextField.clipsToBounds = true
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search lyrics, songs or artists...",
            attributes: [.foregroundColor: UIColor.gray]
        )
        searchBar.setImage(UIImage(named: "ph_magnifying-glass"), for: .search, state: .normal)
        
    }
}
