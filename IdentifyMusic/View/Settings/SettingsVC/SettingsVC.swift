//
//  SettingsVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 22/03/2024.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var navTitleOutlet: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
                let attributes = [NSAttributedString.Key.font: UIFont(name: "Heebo-Regular", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        navTitleOutlet.setTitleTextAttributes(attributes, for: .disabled)
    }
    
    @IBAction func navBackBtnAction(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
        tableView.register(UINib(nibName: "ContactCell", bundle: nil), forCellReuseIdentifier: "ContactCell")
    }
    
    
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
            cell.backgroundColor = .clear
            cell.containerView.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.04)
            cell.clipsToBounds = true
            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
            cell.backgroundColor = .clear
            cell.containerView.backgroundColor = UIColor(hex: "FFFFFF", alpha: 0.04)
            cell.clipsToBounds = true
            return cell
//            cell.backgroundColor = UIColor(hex: "1ED760", alpha: 0.3)


        }

        }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 45
        } else {
            return 56
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Subscription"
        } else if section == 1 {
            return "Accounts"
        } else {
            return "Contact"
        }
    }

    
    
}
