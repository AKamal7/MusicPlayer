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
    
    
    var userToken: String = ""
    var playlistsData: [Cider.Playlist] = []

    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "My playlists"
        
        navigationController?.navigationBar.barTintColor = UIColor(hex: "141414", alpha: 1)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = add
        navigationItem.rightBarButtonItem?.tintColor = .white

        setupView()
        setupTable()
        
        
        authenticateUser { usertoken, error in
            print( "eroor",error)
            print("usertoken",usertoken)
            self.userToken = "\(usertoken ?? "")"
            
            self.fetchMyPlaylists(userToken: self.userToken) { playlists, error in
                print("PLaylists", playlists)
            }
        }
        
    }
    
    // MARK:- Actions
    
    
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



