//
//  HistoryVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/03/2024.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var titleBarItem: UIBarButtonItem!
    
    @IBOutlet weak var tableView: SelfSizedTableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var favoritesLabelOutlet: UILabel!
    @IBOutlet weak var recentlyListenedLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.selectedIndex = 1
        setupTable()
        setupView()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "History"
        navigationController?.navigationBar.barTintColor = UIColor(hex: "141414", alpha: 1)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    @IBAction func favBtnPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MusicTableVC", bundle: nil).instantiateViewController(withIdentifier: "MusicTableVC") as! MusicTableVC
        vc.titleText = "Favorites"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func recenylyListenedBtnPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "MusicTableVC", bundle: nil).instantiateViewController(withIdentifier: "MusicTableVC") as! MusicTableVC
        vc.titleText = "Recently listened"
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

//Private funcs
extension HistoryVC {
    
    private func setupView() {
        view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        
        setupSearchBar()

        let favGradient = getGradientLayer(bounds: favoritesLabelOutlet.bounds)
        let recentlyPlayedGradient = getGradientLayer(bounds: recentlyListenedLabelOutlet.bounds)
        favoritesLabelOutlet.textColor = gradientColor(bounds: favoritesLabelOutlet.bounds, gradientLayer: favGradient)
        recentlyListenedLabelOutlet.textColor = gradientColor(bounds: recentlyListenedLabelOutlet.bounds, gradientLayer: recentlyPlayedGradient)

    }
    
    private func setupNavBar() {
        
        let navC = self.navigationController
        let navB = navC?.navigationBar
        navB?.backgroundColor = UIColor(hex: "141414", alpha: 1)
        
        
        navC?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navC?.navigationBar.shadowImage = UIImage()
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Heebo-Regular", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        titleBarItem.setTitleTextAttributes(attributes, for: .disabled)
        
        
    }
    
  
    
}
