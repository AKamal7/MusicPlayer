//
//  SearchResultsVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/04/2024.
//

import UIKit
import Cider
import SDWebImage
import Alamofire

class SearchResultsVC: UIViewController {
    
    var isYoutube = false
    var songsData: Cider.ResponseRoot<Track>!
    var youtubeVid: [Video] = []
    var offset = 0
    var isPagination = false
    var id: String?

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearchBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
