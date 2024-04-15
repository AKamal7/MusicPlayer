//
//  PlayerVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 20/03/2024.
//

import UIKit

//import SpotlightLyrics

class PlayerVC: UIViewController {

    var isPlaying: Bool = false
    var value: Float = 0.0

    @IBOutlet weak var songImgView: UIImageView!
    @IBOutlet weak var centerDiscView: UIView!
    @IBOutlet weak var mainCenterDiscView: UIView!
    @IBOutlet weak var songNameLbl: UILabel!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var sliderView: CustomSlider!
    
    @IBOutlet weak var lyricsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backBtn = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backTapped))
        
        navigationItem.leftBarButtonItem = backBtn
        navigationItem.leftBarButtonItem?.tintColor = .white

        setupView()
        swipeGesture()
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    
    func swipeGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(detectPan(recognizer:)))
         panGesture.delaysTouchesBegan = false
         panGesture.delaysTouchesEnded = false
         lyricsView.addGestureRecognizer(panGesture)
    }
    
    @objc func detectPan(recognizer: UIPanGestureRecognizer) {

        switch recognizer.state {
        case .began:
            print("StartSwiping")
            
        case .changed:
            print("AlreadySwiping")
        

          
        default:
            break
        }
    }
    
    @IBAction func moreActionsBtn(_ sender: UIButton) {
    }
    
    @IBAction func playBtn(_ sender: UIButton) {
        if isPlaying {
            isPlaying = false
            songImgView.layer.removeAllAnimations()
            playBtn.setImage(UIImage(named: "play"), for: .normal)

        } else {
            isPlaying = true
            songImgView.rotate360Degrees()
            playBtn.setImage(UIImage(named: "pause"), for: .normal)

        }
        
    }
    
    @IBAction func backwardBtn(_ sender: UIButton) {
    }
    
    @IBAction func thirtySecPreviewBtn(_ sender: UIButton) {
    }
    
    @IBAction func forwardBtn(_ sender: UIButton) {
    }
    
    @IBAction func rewindBtn(_ sender: UIButton) {
    }
    
    @IBAction func sliderChanged(_ sender: CustomSlider) {
//        sliderView.bufferProgress.progress += 0.1
//        if sender.value > self.value {
//                    sender.setValue(self.value, animated: false)
//                } else {
//                    self.value = sliderView.bufferProgress.progress
//                }
        self.sliderView.value = sender.value
        //self.sliderView.thumbImage(for: .normal)
        print(sender.value, "value")
    }
    
    
    
}

//Private funcs
extension PlayerVC {
    
    private func setupView() {
        songImgView.cornerRadius = songImgView.frame.width / 2
        
        
       
    }
}

class CustomSlider: UISlider {
    
    @IBInspectable var trackHeight: CGFloat = 3
    
    @IBInspectable var thumbRadius: CGFloat = 20
    
    // Custom thumb view which will be converted to UIImage
    // and set as thumb. You can customize it's colors, border, etc.
    private lazy var thumbView: UIView = {
        let thumb = UIView()
        thumb.backgroundColor = .white//thumbTintColor
        thumb.layer.borderWidth = 0.4
        thumb.layer.borderColor = UIColor.darkGray.cgColor
        return thumb
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let thumb = thumbImage(radius: thumbRadius)
        setThumbImage(thumb, for: .normal)
        setThumbImage(thumb, for: .highlighted)
    }
    
    private func thumbImage(radius: CGFloat) -> UIImage {
        // Set proper frame
        // y: radius / 2 will correctly offset the thumb
        
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        thumbView.layer.cornerRadius = radius / 2
        
        // Convert thumbView to UIImage
        // See this: https://stackoverflow.com/a/41288197/7235585
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        // Set custom track height
        // As seen here: https://stackoverflow.com/a/49428606/7235585
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackHeight
        return newRect
    }
    
}


extension PlayerVC: UIViewControllerTransitioningDelegate {
    // 2.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        FilterPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
