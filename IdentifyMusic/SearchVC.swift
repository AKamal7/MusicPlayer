//
//  ViewController.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit

import UIKit

class SearchVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        tabBarController?.selectedIndex = 1
        self.view.backgroundColor = .black
      
        // Create a search bar
          let searchBar = UISearchBar()
          searchBar.placeholder = "Search lyrics, songs or artists..."
          searchBar.delegate = self

          // Create a bar button item

        let barButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(addButtonTapped))

          // Add the search bar and the bar button item to the navigation item
          navigationItem.titleView = searchBar
          navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func addButtonTapped() {
        
    }
    

}


extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Perform search operation
        searchBar.resignFirstResponder() // Close the keyboard
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear the search bar and dismiss the search
        searchBar.text = nil
        searchBar.resignFirstResponder() // Close the keyboard
    }
}


