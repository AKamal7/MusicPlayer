//
//  PlayerVC.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 20/03/2024.
//

import UIKit
import AVFoundation
import Cider
import MediaPlayer
import StoreKit

//import SpotlightLyrics

class PlayerVC: UIViewController {
    var songData: Cider.Track?

    
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
    
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let songData {
            if let attributes = songData.attributes {
                songNameLbl.text = attributes.name
                artistNameLbl.text = attributes.artistName
            }
        }
        if isAuthorized {
            musicPlayer = MPMusicPlayerController.applicationMusicPlayer
            if let songId = songData?.attributes?.playParams?.id {
                musicPlayer.setQueue(with: [songId])
                musicPlayer.prepareToPlay()
            }
        } else {
            if let url = songData?.attributes?.previews[0].url {
                if  let songURL = URL(string: url) {
                        player = AVPlayer(url: songURL)
                        player.volume = 1
                    
                    print(url, "adsfgasdga")
                }
            }
            
        }
        if !isAuthorized {
            NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying), name: AVPlayerItem.didPlayToEndTimeNotification, object: player.currentItem)
        }
        
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
        print(isAuthorized, "adsgfasdgas")
        if isAuthorized {
            fullDurationLabel.text  = musicPlayer.nowPlayingItem?.playbackDuration.MinuteSeconds
        } else {
            fullDurationLabel.text = "00:30"
        }
        
        durationLiveLabel.text  = "00:00"
        if isAuthorized {
            sliderView.maximumValue = Float(musicPlayer.nowPlayingItem?.playbackDuration ?? 0)
        } else {
            if let currentItem = player.currentItem {
                sliderView.maximumValue = Float(CMTimeGetSeconds(currentItem.asset.duration))
            }
            
        }
        startTimer()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("UpdatePlayer"),
                                                object: nil,
                                                userInfo: nil)
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        // Your code here
        isPlaying = false
        songImgView.layer.removeAllAnimations()
        playBtn.setImage(UIImage(named: "play"), for: .normal)
        self.durationLiveLabel.text = "00:00"
        self.sliderView.value = 0
        player.pause()
        player.seek(to: .zero)
    }
    
    func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(update), userInfo: nil,repeats: true)
            timer.fire()
        }
    }

    func stopTimer(){
        timer.invalidate()

    }
    
    @objc func update(){
        if isAuthorized {
            if musicPlayer.playbackState == .playing{
                isPlaying = true
//                songImgView.rotate360Degrees()
                playBtn.setImage(UIImage(named: "pause"), for: .normal)
                durationLiveLabel.text  = musicPlayer.currentPlaybackTime.MinuteSeconds
                sliderView.value = Float(musicPlayer.currentPlaybackTime)
            } else if musicPlayer.playbackState == .paused {
                isPlaying = false
                songImgView.layer.removeAllAnimations()
                playBtn.setImage(UIImage(named: "play"), for: .normal)
            } else {
                isPlaying = false
                songImgView.layer.removeAllAnimations()
                playBtn.setImage(UIImage(named: "play"), for: .normal)
                self.durationLiveLabel.text = "00:00"
                self.sliderView.value = 0
                
            }
        } else {
            let currentTimeInSeconds = CMTimeGetSeconds(player.currentTime())
                // 2 Alternatively, you could able to get current time from `currentItem` - videoPlayer.currentItem.duration

                let mins = currentTimeInSeconds / 60
                let secs = currentTimeInSeconds.truncatingRemainder(dividingBy: 60)
                let timeformatter = NumberFormatter()
                timeformatter.minimumIntegerDigits = 2
                timeformatter.minimumFractionDigits = 0
                timeformatter.roundingMode = .down
            guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
                   return
               }
               durationLiveLabel.text = "\(minsStr):\(secsStr)"
               sliderView.value = Float(currentTimeInSeconds)
//            if player. == .readyToPlay {
//                durationLiveLabel.text  = player?.currentItem?.currentTime().positionalTime
////                sliderView.value = Float(player?.currentItem?.currentTime().seconds ?? 0)
//            }
        }
        

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
            if isAuthorized {
                musicPlayer.pause()
            } else {
                player.pause()
            }
        } else {
            isPlaying = true
            songImgView.rotate360Degrees()
            playBtn.setImage(UIImage(named: "pause"), for: .normal)
            
            if isAuthorized {
                musicPlayer.play()
            } else {
                player.play()
                
            }
            
        }
       
    }
    
    @IBAction func backwardBtn(_ sender: UIButton) {
        if isAuthorized {
            if musicPlayer.currentPlaybackTime < 5 {
                musicPlayer.skipToPreviousItem()
            } else {
                musicPlayer.skipToBeginning()
            }
        }
        
    }
    
    @IBAction func thirtySecPreviewBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func forwardBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func rewindBtn(_ sender: UIButton) {
        
    }
    
    @IBAction func sliderChanged(_ sender: CustomSlider) {
        self.sliderView.value = sender.value
        if isAuthorized {
            musicPlayer.currentPlaybackTime = TimeInterval(sliderView.value)
            self.durationLiveLabel.text = TimeInterval(sliderView.value).MinuteSeconds
        } else {
            let currentTimeInSeconds = CMTimeGetSeconds(player.currentTime())
                let mins = currentTimeInSeconds / 60
                let secs = currentTimeInSeconds.truncatingRemainder(dividingBy: 60)
                let timeformatter = NumberFormatter()
                timeformatter.minimumIntegerDigits = 2
                timeformatter.minimumFractionDigits = 0
                timeformatter.roundingMode = .down
            guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
                return
            }
            durationLiveLabel.text = "\(minsStr):\(secsStr)"
            
            player.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: 1))
            
        }
        
        
        print(sender.value, "value")
    }
    
//    func humanReadable(time:Double) -> String {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.hour, .minute, .second]
//        formatter.unitsStyle = .full
//        if let str = formatter.string(from: time) {
//            return str
//        }
//        return "" // empty string if number fails
//    }
    
    
    
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

extension TimeInterval {
    var MinuteSeconds: String {
        String(format:"%02d:%02d", minute, second)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*1000).truncatingRemainder(dividingBy: 1000))
    }
}

extension CMTime {
    var roundedSeconds: TimeInterval {
        return seconds.rounded()
    }
    var hours:  Int { return Int(roundedSeconds / 3600) }
    var minute: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 3600) / 60) }
    var second: Int { return Int(roundedSeconds.truncatingRemainder(dividingBy: 60)) }
    var positionalTime: String {
        return hours > 0 ?
            String(format: "%d:%02d:%02d",
                   hours, minute, second) :
            String(format: "%02d:%02d",
                   minute, second)
    }
}

