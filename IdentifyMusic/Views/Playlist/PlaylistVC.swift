//
//  PlaylistVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 14/3/2024.
//

import UIKit

class PlaylistVC: UIViewController {
    
    // MARK:- Variables
    @IBOutlet var playlistView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var trendsLabel: UILabel!
    @IBOutlet weak var seeAllBtn: UIButton!
    @IBOutlet weak var seeAllPlystBtn: UIButton!
    @IBOutlet weak var playlistLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createNewPlylstView: UIView!
    @IBOutlet weak var createNewPlistLbl: UILabel!
    @IBOutlet weak var musicIconView: UIImageView!
    // MARK:- LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTable()
        
    }
    @IBAction func seeAllBtnClicked(_ sender: Any) {
        print("btn clicked")
    }
    @IBAction func seeAllPlyLstBtnClicked(_ sender: Any) {
        print("btn clicked")
    }
    // MARK:- Public Methods
    // MARK:- Private Methods
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func setupView() {
        self.view.backgroundColor = Colors.mainBackground
        setupNavBar()
        setupSearchBar()
        setupWhiteLabel(label: trendsLabel, text: "Trends")
        setupWhiteLabel(label: playlistLabel, text: "My playlist")
        setupSeeAllButton(button: seeAllBtn)
        setupSeeAllButton(button: seeAllPlystBtn)
        setupNewPlylstView()
        setupMusicIconImgView()
        setupMusicNewPlistLbl()
    }
    
//
    
    private func setupNavBar() {

        let navC = self.navigationController
        let navB = navC?.navigationBar
        navB?.backgroundColor = Colors.mainBackground
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
    private func setupWhiteLabel(label: UILabel, text: String) {
        label.text = text
        trendsLabel.textColor = .white
    }
    private func setupSeeAllButton(button: UIButton) {
        
        button.setImage(UIImage(named: "seeAll"), for: .normal)
        button.setTitle("", for: .normal)
        
       
    }
    private func setupNewPlylstView() {
        
        createNewPlylstView.backgroundColor = Colors.createPlistView
    }
    private func setupMusicIconImgView() {
//        musicIconView.backgroundColor = Colors.createPlistView
        musicIconView.layer.borderWidth = 1
        musicIconView.image = UIImage(named: "musicIcon")
       
    }
    private func setupMusicNewPlistLbl() {
        createNewPlistLbl.text = "create new playlist"
        createNewPlistLbl.font = UIFont(name: "Heebo-Regular", size: 18)
    }
    // MARK:- Objc methods
    

}



extension PlaylistVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            guard !searchText.isEmpty else {
                return
            }
        }
    
}

extension PlaylistVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        112
    }
    
    
}

