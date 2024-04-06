//
//  PlaylistsTableVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 7/4/2024.
//

import UIKit

class PlaylistsTableVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = UIColor(hex: "141414")
        
        
        setupTable()
        setupNavBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.barTintColor = UIColor(hex: "141414")
        
        navigationController?.navigationBar.tintColor = .white
        
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        
    }

    

}


extension PlaylistsTableVC: plistTabelCellProtocol {
    func presentView() {
        let pListOptionsVC = UIStoryboard(name: "PListOptionsVC", bundle: nil).instantiateViewController(withIdentifier: "PListOptionsVC") as! PListOptionsVC
        pListOptionsVC.modalPresentationStyle = .overFullScreen
        self.present(pListOptionsVC, animated: false, completion: nil)
    }
    
    
}
