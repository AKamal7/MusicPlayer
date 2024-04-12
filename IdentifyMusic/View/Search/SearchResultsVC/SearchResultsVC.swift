//
//  SearchResultsVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/04/2024.
//

import UIKit

class SearchResultsVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearchBar()
    }
    
    
    

   
}
