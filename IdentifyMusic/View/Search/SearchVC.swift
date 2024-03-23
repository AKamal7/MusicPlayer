//
//  ViewController.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit
import MediaPlayer

class SearchVC: UIViewController {

    
    @IBOutlet weak var playerBtnOutlet: UIButton!
    
    let player = MPMusicPlayerController.systemMusicPlayer

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        tabBarController?.selectedIndex = 0
        // Create a search bar
          let searchBar = UISearchBar()
          searchBar.placeholder = "Search lyrics, songs or artists..."
          searchBar.delegate = self
        searchBar.searchTextField.layer.borderColor = UIColor(hex: "2B2B2B").cgColor
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.cornerRadius = 12
          // Create a bar button item

        let barButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(addButtonTapped))

          // Add the search bar and the bar button item to the navigation item
          navigationItem.titleView = searchBar
          navigationItem.rightBarButtonItem = barButtonItem
        
//        var playerQueue = PlayerQueue()
//        if let song = player.nowPlayingItem {
//            let id = song.playbackStoreID
//           }
    }
    
    @objc func addButtonTapped() {
        let vc = UIStoryboard(name: "SettingsVC", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func playerBtnPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "PlayerVC", bundle: nil).instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
        navigationController?.pushViewController(vc, animated: true)
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


