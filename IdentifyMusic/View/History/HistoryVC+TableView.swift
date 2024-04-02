
//
//  PlistVC + TableView.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 19/3/2024.
//

import Foundation
import UIKit



extension HistoryVC: UITableViewDelegate, UITableViewDataSource {
    

   
    // Register TableView Cell
    func registerCell() {
        tableView.register(UINib(nibName: "PlistTableCell", bundle: nil), forCellReuseIdentifier: "PlistTableCell")
    }
    
    // Setting up tableView
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Colors.mainBackground
        registerCell()
    }
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    // Config cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlistTableCell", for: indexPath) as? PlistTableCell else {
            return UITableViewCell()
        }
        
        // Config cell
        cell.backgroundColor = UIColor(hex: "141414", alpha: 1)
        cell.clipsToBounds = true
        cell.containerView.backgroundColor = UIColor(hex: "1f1f1f")
        cell.containerView.layer.cornerRadius = 12
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ay 7aga")
    }
}
