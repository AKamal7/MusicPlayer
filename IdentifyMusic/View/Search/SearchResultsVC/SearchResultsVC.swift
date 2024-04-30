//
//  SearchResultsVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 09/04/2024.
//

import UIKit
import Cider
import SDWebImage

class SearchResultsVC: UIViewController {
    
    var songsData: Cider.ResponseRoot<Track>!
    var offset = 0
    var isPagination = false
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearchBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
//    func downloadImage(with item: URL, completion: @escaping (UIImage?) -> Void) {
//
//        SDWebImageManager.shared.loadImage(with: URL(string: item.attributes?.artwork.url), options: .highPriority, progress: nil) { (image, _, error, _, _, _) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let image = image {
//                completion(image)
//            }
//        }
//    }
    

   
}
