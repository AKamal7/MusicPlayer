//
//  PlaylistVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 14/3/2024.
//

import UIKit
import MusicKit
import Cider
import StoreKit
import MusadoraKit


class PlaylistVC: UIViewController {
    
    // MARK:- Variables
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var playlistView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var trendsLabel: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var seeAllPlystBtn: UIButton!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var tableView: SelfSizedTableView!
    @IBOutlet weak var createNewPlylstView: UIView!
    @IBOutlet weak var musicIconView: UIImageView!
    @IBOutlet weak var creatPlistImgView: UIImageView!
    
//    var genres: [GenreData] = []
    var userToken: String = ""
    var playlistsData: [Cider.Playlist] = []
    var fetchedPlaylists: [Playlist] = []

    
    
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        
        setupView()
        setupTable()
        fetchUserData()
        
    }
    
    // Mark:-

    
    // MARK:- Actions
    
    private func fetchUserData() {
        authenticateUser { usertoken, error in
            print( "eroor",error)
            print("usertoken",usertoken)
            
            
            self.userToken = "\(usertoken ?? "")"
            GenreAPI.fetchGenres { result in
                switch result {
                case .success(let genres):
                    // Handle fetched genres
                    print("Fetched genres: \(genres)")
                case .failure(let error):
                    // Handle error
                    print("Error fetching genres: \(error)")
                }
            }
            
            
            self.fetchMyPlaylists(userToken: self.userToken) { playlists, error in
                print("PLaylists", playlists)
                
                
                if let playlists = playlists {
                    self.fetchedPlaylists = playlists
                    self.fetchedPlaylists = self.fetchedPlaylists.filter({$0.attributes.playParams.globalId != nil})
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    print("Fetched \(self.fetchedPlaylists.count) playlists:")
                    for playlist in self.fetchedPlaylists {
                        print("Name: \(playlist.attributes.name)")
                        print("Last Modified Date: \(playlist.attributes.lastModifiedDate)")
                        // Print other playlist attributes as needed...
                    }
                    // Now you can use fetchedPlaylists variable elsewhere in your app
                } else {
                    print("No playlists fetched")
                }
            
            }
            
        }
    }
    
    @IBAction func seeAllBtnClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "TrendsCollectionVC", bundle: nil).instantiateViewController(withIdentifier: "TrendsCollectionVC") as! TrendsCollectionVC
        navigationController?.pushViewController(vc, animated: false)
        print("btn clicked")
    }
    
    @IBAction func seeAllPlyLstBtnClicked(_ sender: Any) {
        print("btn clicked")
        let vc = UIStoryboard(name: "PlaylistsTableVC", bundle: nil).instantiateViewController(withIdentifier: "PlaylistsTableVC") as! PlaylistsTableVC
        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func createNewPlistBtn(_ sender: Any) {
        let createPlistVC = UIStoryboard(name: "CreatePlistVC", bundle: nil).instantiateViewController(withIdentifier: "CreatePlistVC") as! CreatePlistVC
        createPlistVC.modalPresentationStyle = .fullScreen
        self.present(createPlistVC, animated: false, completion: nil)
    }
    
    // MARK:- Private Methods
    private func setupView() {
        self.view.backgroundColor = UIColor(hex: "141414")
//        Public.setupLabelWithMedium(label: titleLabel, text: "My Playlist", size: 20, color: .white)
        contentView.backgroundColor = UIColor(hex: "141414")
        
        
//        setupNavBar()
        setupSearchBar()
        Public.setupLabelWithMedium(label: trendsLabel, text: "Trends", size: 18, color: .white)
        Public.setupLabelWithMedium(label: playlistLabel, text: "My playlists", size: 18, color: .white)
        setupSeeAllButton(button: seeAllBtn)
        setupSeeAllButton(button: seeAllPlystBtn)
        setupNewPlylstView()
        setupMusicIconImgView()
        setupMusicNewPlistImgView()
        setupCollectionView()
        setupTable()
        
    }
    
    @objc func addTapped() {
        let createPlistVC = UIStoryboard(name: "CreatePlistVC", bundle: nil).instantiateViewController(withIdentifier: "CreatePlistVC") as! CreatePlistVC
        createPlistVC.modalPresentationStyle = .fullScreen
        self.present(createPlistVC, animated: false, completion: nil)
    }
    
    // Function to authenticate the user using MusicKit

    
    private func setupWhiteLabel(label: UILabel, text: String) {
        label.text = text
        trendsLabel.textColor = .white
    }
    private func setupSeeAllButton(button: UIButton) {
        
        
       
        button.setImage(UIImage(named: "seeAll"), for: .normal)
        button.setTitle("", for: .normal)
        
        
    }
    
    private func setupNewPlylstView() {
        
        createNewPlylstView.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.04)
        createNewPlylstView.layer.cornerRadius = 12
        createNewPlylstView.layer.borderWidth = 1
    }
    private func setupMusicIconImgView() {
        //        musicIconView.backgroundColor = Colors.createPlistView
        musicIconView.layer.borderWidth = 1
        musicIconView.layer.borderColor = UIColor(hex: "BC66FF0A", alpha: 0.04).cgColor
        musicIconView.image = UIImage(named: "musicIcon")
        
    }
    private func setupMusicNewPlistImgView() {
        creatPlistImgView.image = UIImage(named: "createNewPlaylist")
        
    }
    
    
}


extension PlaylistVC: plistTabelCellProtocol {
    func presentView() {
        let pListOptionsVC = UIStoryboard(name: "PListOptionsVC", bundle: nil).instantiateViewController(withIdentifier: "PListOptionsVC") as! PListOptionsVC
        pListOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(pListOptionsVC, animated: false, completion: nil)
    }
    
    
}



