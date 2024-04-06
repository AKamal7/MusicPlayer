
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
        tableView.register(UINib(nibName: "HistoryTableCell", bundle: nil), forCellReuseIdentifier: "HistoryTableCell")
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableCell", for: indexPath) as? HistoryTableCell else {
            return UITableViewCell()
        }
        
        // Config cell
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ay 7aga")
        let player = UIStoryboard(name: "PlayerVC", bundle: nil).instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
        player.modalPresentationStyle = .fullScreen
        player.modalTransitionStyle = .crossDissolve
        self.present(player, animated: true)
       // self.navigationController?.pushViewController(player, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    
    
    
}
