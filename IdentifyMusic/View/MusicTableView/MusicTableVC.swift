//
//  MusicTableVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 7/4/2024.
//

import UIKit
import Cider

class MusicTableVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var fetchedPlaylists: Playlist!
    var playlist: Cider.Playlist?
    
    var titleText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
    }
    
    //MARK:- private methods
    
    private func setupView() {
        
        view.backgroundColor = UIColor(hex: "141414")
        titleLabel.text = titleText
        
        setupTable()
        setupNavBar()
        
        let client = CiderClient(storefront: .egypt, developerToken: UserDefaultsManager.shared().token ?? "")
        
        client.playlist(id: fetchedPlaylists.attributes.playParams.globalId ?? "") { results, error in
            self.playlist = results
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("id", results)
            print("error",error)
        }
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "141414")
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        
    }

}
