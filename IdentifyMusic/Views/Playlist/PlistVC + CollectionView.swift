//
//  PlistVC + CollectionView.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 19/3/2024.
//

import Foundation
import UIKit

// MARK:- Collection view
extension PlaylistVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        collectionView.backgroundColor = UIColor(hex: "141414")
        collectionView.delegate   = self
        collectionView.dataSource = self
        registerCollectionCell()
        
    }
    
    func registerCollectionCell() {
        collectionView.register(UINib(nibName: "TrendsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "TrendsCollectionCell" )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendsCollectionCell", for: indexPath) as? TrendsCollectionCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor(hex: "1f1f1f")
        cell.layer.cornerRadius = 12
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor(hex: "FFFFFF", alpha: 0.04).cgColor
        cell.imgView.image = UIImage(named: "musicIcon")
        cell.trendsLabel.text = "trendName02"
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 110, height: 129)
    }
    
}
