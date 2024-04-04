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
        setupNavBar()
    }
    
    @IBAction func favBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func recenylyListenedBtnPressed(_ sender: UIButton) {
        
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
