//
//  ViewController.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit
import MediaPlayer

class SearchVC: UIViewController {

    
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var recognitionBtnOutlet: UIButton!
    @IBOutlet weak var playerBtnOutlet: UIButton!
    
    let player = MPMusicPlayerController.systemMusicPlayer
    var isHearing: Bool = false
    
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
        
        let closeRecognition = UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(closeRecognition))
        navigationItem.leftBarButtonItem = closeRecognition
        if #available(iOS 16.0, *) {
            closeRecognition.isHidden = true
        } else {
            // Fallback on earlier versions
        }
        
          // Add the search bar and the bar button item to the navigation item
          navigationItem.titleView = searchBar
          navigationItem.rightBarButtonItem = barButtonItem
        
    
    }
    
    @objc func addButtonTapped() {
        let vc = UIStoryboard(name: "SettingsVC", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func closeRecognition() {
        navigationItem.titleView?.isHidden = false
        if #available(iOS 16.0, *) {
            navigationItem.rightBarButtonItem?.isHidden = false
            adView.isHidden = false
            navigationItem.leftBarButtonItem?.isHidden = true
            self.view.backgroundColor = .black

        } else {
            // Fallback on earlier versions
        }

        print("2")
    }
    
    
    
    @IBAction func recognitionBtnPressed(_ sender: UIButton) {

            navigationItem.titleView?.isHidden = true
            if #available(iOS 16.0, *) {
                navigationItem.rightBarButtonItem?.isHidden = true
                navigationItem.leftBarButtonItem?.isHidden = false
                self.view.backgroundColor = UIColor(hex: "1E1029", alpha: 1)
                adView.isHidden = true
            } else {
                // Fallback on earlier versions
            }
            print("1")
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


