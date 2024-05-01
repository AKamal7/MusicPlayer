//
//  PlayerVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 20/03/2024.
//

import UIKit
import AVFoundation
import Cider

//import SpotlightLyrics

class PlayerVC: UIViewController {
    var songData: Cider.Track?

    var isPlaying: Bool = false
    var value: Float = 0.0

    @IBOutlet weak var songImgView: UIImageView!
    @IBOutlet weak var centerDiscView: UIView!
    @IBOutlet weak var mainCenterDiscView: UIView!
    @IBOutlet weak var songNameLbl: UILabel!
    @IBOutlet weak var artistNameLbl: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var sliderView: CustomSlider!
    
    @IBOutlet weak var songBckGroundHeight: NSLayoutConstraint!
    @IBOutlet weak var songTop: NSLayoutConstraint!
    @IBOutlet weak var lyricsView: UIView!
    @IBOutlet weak var lyricsHeaderView: UIView!
    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var lyricsHeight: NSLayoutConstraint!
    @IBOutlet weak var lyricsTopAnchor: NSLayoutConstraint!
    @IBOutlet weak var lyricsTextTitle: UILabel!
    @IBOutlet weak var lyricsBotBorder: UIView!
    @IBOutlet weak var titleLabelsStack: UIStackView!
    @IBOutlet weak var lyricsBotConst: NSLayoutConstraint!
    @IBOutlet weak var durationLiveLabel: UILabel!
    @IBOutlet weak var fullDurationLabel: UILabel!
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        let backBtn = UIBarButtonItem(image: UIImage(named: "backButton"), style: .plain, target: self, action: #selector(backTapped))
        
        navigationItem.leftBarButtonItem = backBtn
        navigationItem.leftBarButtonItem?.tintColor = .white
        applyBlurEffect(to: lyricsView)
        setupView()
        swipeGesture()
        titleLabelsStack.isHidden = true
        lyricsTopAnchor.constant = (self.view.frame.height * 0.63)
        songBckGroundHeight?.constant = 300
        lyricsHeight.constant = 400

        
             
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func applyBlurEffect(to view: UIView) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, belowSubview: view)
        view.insertSubview(lyricsHeaderView, aboveSubview: view)
        view.insertSubview(lyricsTextView, aboveSubview: view)
  
      }
    
    func setBlurView() {
        // Init a UIVisualEffectView which going to do the blur for us
        let blurView = UIVisualEffectView()
        // Make its frame equal the main view frame so that every pixel is under blurred
        blurView.frame = view.frame
        // Choose the style of the blur effect to regular.
        // You can choose dark, light, or extraLight if you wants
        blurView.effect = UIBlurEffect(style: .regular)
        // Now add the blur view to the main view
        //           view.addSubview(blurView)
        view.addSubview(blurView)

    }

    
    func swipeGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        lyricsView.addGestureRecognizer(panGesture)
         panGesture.delaysTouchesBegan = false
         panGesture.delaysTouchesEnded = false
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        
        guard let view = gesture.view else { return }
        lyricsTopAnchor.isActive = true
        switch gesture.state {
        case .began, .changed:
            
            let translation = gesture.translation(in: view.superview)
            let velocity = gesture.velocity(in: view.superview)
            
            // Check the direction of the pan gesture
            if velocity.y < 0 {
                let updatedHeight = min(max(300, 1000 - translation.y), 1000)
                songBckGroundHeight?.constant = updatedHeight
                lyricsTopAnchor.constant = 100
                lyricsHeight.constant = self.view.frame.height
                titleLabelsStack.isHidden = false

                lyricsBotConst.constant = 80
                
            } else {
                let updatedHeight = max(min(1000, 300 - translation.y), 300)
                songBckGroundHeight?.constant = updatedHeight
                lyricsTopAnchor.constant = (self.view.frame.height * 0.63)
                lyricsHeight.constant = 200
                titleLabelsStack.isHidden = true
            }
            
            // Update the pan gesture translation
            gesture.setTranslation(.zero, in: view.superview)
            
            // Animate the image size change
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
        default:
            break
        }
    }

    @IBAction func moreActionsBtn(_ sender: UIButton) {
        let vc = UIStoryboard(name: "LinkedAccountVC", bundle: nil).instantiateViewController(withIdentifier: "LinkedAccountsVC") as! LinkedAccountsVC
        vc.modalPresentationStyle = .custom
        self.present(vc,  animated: true)
        setBlurView()
        vc.delegate = self
    }
    
    @IBAction func playBtn(_ sender: UIButton) {
        if isPlaying {
            isPlaying = false
            songImgView.layer.removeAllAnimations()
            playBtn.setImage(UIImage(named: "play"), for: .normal)
            player?.pause()
        } else {
            isPlaying = true
            songImgView.rotate360Degrees()
            playBtn.setImage(UIImage(named: "pause"), for: .normal)
            
            //let url = "https://music.apple.com/eg/\(songData?.attributes?.playParams?.kind ?? "")/\(songData?.attributes?.playParams?.id ?? "")"
            guard let url = songData?.attributes?.previews[0].url else { return }
            
            guard let songURL = URL(string: url) else {
                return
            }
            print(url, "SONG URL")
            
            self.player = AVPlayer(url: songURL)
            player?.play()
            print(url, "Song URL")
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
        self.sliderView.value = sender.value
        print(sender.value, "value")
    }
    
    
    
}

//Private funcs
extension PlayerVC {
    
    func formatMmSs(counter: Int) -> String {
        let minutes = Int(counter) / 60 % 60
        let seconds = Int(counter) % 60
        let milliseconds = Int(counter*1000) % 1000
        return String(format: "%02d:%02d:%03d", minutes, seconds, milliseconds)
    }
    
    private func setupView() {
        songImgView.cornerRadius = songImgView.frame.height / 2
        centerDiscView.cornerRadius = centerDiscView.frame.width / 2
        mainCenterDiscView.cornerRadius = mainCenterDiscView.frame.width / 2
        if let attributes = songData?.attributes {
            let imgString = attributes.artwork.url.replacingOccurrences(of: "{w}", with: "\(attributes.artwork.width)")
            let imgStringEnhanced = imgString.replacingOccurrences(of: "{h}", with: "\(attributes.artwork.height)")
            let imgUrl = URL(string: imgStringEnhanced)
            songImgView.sd_setImage(with: imgUrl)
            durationLiveLabel.text = formatMmSs(counter: songData?.attributes?.durationInMillis ?? 0)
            
        }
        
       
    }
}

class CustomSlider: UISlider {
    
    @IBInspectable var trackHeight: CGFloat = 3
    
    @IBInspectable var thumbRadius: CGFloat = 20
    
    
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
      
        
        thumbView.frame = CGRect(x: 0, y: radius / 2, width: radius, height: radius)
        thumbView.layer.cornerRadius = radius / 2
        
       
        
        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        
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

extension PlayerVC: BlurVCDelegate {
    
    func removeBlurView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
        
        
        
    }
}
