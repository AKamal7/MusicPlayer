//
//  PlaylistVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 14/3/2024.
//

import UIKit

class PlaylistVC: UIViewController {

    @IBOutlet var playlistView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var trendsLabel: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        
    }
    private func setupView() {
        self.view.backgroundColor = Colors.mainBackground
        setupNavBar()
        setupSearchBar()
        setupTrendsLabel()
        setupSeeAllButton()
    }
    private func setupNavBar() {
        
        let navC = self.navigationController
        let navB = navC?.navigationBar
        
        //SettingUp title
        let title = UILabel()
        title.text      = "My playlist"
        title.textColor = .white
        title.font = UIFont(name: "Heebo-Regular", size: 20)
        
        //Setting up Spacer
        let spacer      = UIView()
        let constraint  = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
        constraint.isActive = true
        constraint.priority = .defaultLow
        
        //Creating stackView
        let stack                = UIStackView(arrangedSubviews: [title, spacer])
        stack.axis               = .horizontal
        navigationItem.titleView = stack
        
        //Setting up backButton
        let lButton = UIBarButtonItem()
        navB?.topItem?.leftBarButtonItem = lButton
        lButton.image = UIImage(named: "backButton")
        
        //Setting up rightButton
        let rButton = UIBarButtonItem()
        navB?.topItem?.rightBarButtonItem = rButton
        rButton.image = UIImage(named: "addButton")
        
        //SettingUp constraints
        
        
        
        
        
    }
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 15, vertical: 0)
        searchBar.searchTextField.backgroundColor = Colors.mainBackground
        searchBar.searchTextField.textColor = .white
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.layer.frame = CGRect(x: 0, y: 0, width: 382, height: 45)
        searchBar.searchTextField.layer.borderWidth = 1
        searchBar.searchTextField.layer.borderColor = Colors.searchBarColor.cgColor
        searchBar.searchTextField.layer.cornerRadius = 12
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor.gray]
        )
        searchBar.setImage(UIImage(), for: .search, state: .normal)
    }
    private func setupTrendsLabel() {
        trendsLabel.text = "Trends"
        trendsLabel.textColor = .white
    }
    private func setupSeeAllButton() {
        
        seeAllBtn.setImage(UIImage(named: "seeAll"), for: .normal)
        seeAllBtn.setTitle("", for: .normal)
        
       
    }
}



extension PlaylistVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
                return
            }
        }
    
}

