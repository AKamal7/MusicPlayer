//
//  LunchScreenLoadVC.swift
//  IdentifyMusic
//
//  Created by Khaled Abo hassob on 6/4/2024.
//

import UIKit

class LunchScreenLoadVC: UIViewController {
    @IBOutlet weak var loadingSloder: CustomSlider!
    
    var timer: Timer!
    var count: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func fireTimer() {
        
        if count < 1 {
            count += 0.5
            loadingSloder.setValue(count, animated: true)
        } else {
            timer.invalidate()
            let tabbar = MainTabBar.create()
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            guard let window = appDelegate.window else {return}
            
            window.rootViewController = tabbar
        }
        
        
        
        
        
        
        print("Timer fired!")
    }
    
    
}
