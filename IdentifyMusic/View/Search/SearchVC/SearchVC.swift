//
//  ViewController.swift
//  IdentifyMusic
//
//  Created by ahmedkamal on 08/03/2024.
//

import UIKit
import MediaPlayer
import Cider
import CupertinoJWT
import StoreKit
import Alamofire

//import Metal
//import Accelerate

class SearchVC: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var settingBtn: UIButton!
    
    @IBOutlet weak var searchBtnOutlet: UIButton!
    @IBOutlet weak var adView: UIView!
    
    @IBOutlet weak var songImgView: UIImageView!
    
    
    @IBOutlet weak var instructionsView: UIView!
    
    @IBOutlet weak var pulsyContainerView: UIView!
    
    @IBOutlet weak var closeRecognitionBtn: UIButton!
    
    @IBOutlet weak var hummingResponseLbl: UILabel!
    @IBOutlet weak var assistLabel: UIView!
    
    //RedScreen
    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var backLbl: UILabel!
    @IBOutlet weak var noSongAlertLbl: UIView!
    @IBOutlet weak var tapLbl: UILabel!
    @IBOutlet weak var pulsyBtn: UIButton!
    
    var isPaused = true
    var timer = Timer()
    var audioRecorder: AVAudioRecorder?
    var isRecording = false
    
    //    var engine : AVAudioEngine!
    //    private var magnitudes: [Float] = []
    //    private let metalView = MetalView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    //    private let circularView = CircularSoundWaveView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        circularView.center = pulsyBtn.center
        //        pulsyBtn.addSubview(circularView)
        
        checkMicrophoneAccess()
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        backBtnOutlet.isHidden = true
        backLbl.isHidden = true
        noSongAlertLbl.isHidden = true
        tapLbl.isHidden = true

        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
        setupView()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        setupPulsy()
    }
    
    @IBAction func pulsyBtnPressed(_ sender: UIButton) {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
        let vc = UIStoryboard(name: "SearchResultsVC", bundle: nil).instantiateViewController(withIdentifier: "SearchResultsVC") as! SearchResultsVC
        self.navigationController?.pushViewController(vc, animated: false)
        print("ahaahah")
    }
    
    @IBAction func searchClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        
        backToOriginal()
    }
    
    func fetchMyPlaylists(userToken: String, completion: @escaping ([Playlist]?, Error?) -> Void) {
        let baseURL = "https://api.music.apple.com"
        let endpoint = "/v1/catalog/eg/songs/1411629089"
        let url = URL(string: "\(baseURL)\(endpoint)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(UserDefaultsManager.shared().token ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("\(userToken)", forHTTPHeaderField: "Music-User-Token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(nil, error ?? NSError(domain: "MusicManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data returned"]))
                return
            }
            
            do {
                let playlistResponse = try JSONDecoder().decode(PlaylistResponse.self, from: data)
                completion(playlistResponse.data, nil)
                
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
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
    
    //RecordingStates
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("recording.m4a") {
                audioRecorder = try AVAudioRecorder(url: url, settings: settings)
                audioRecorder?.delegate = self
                audioRecorder?.record()
                isRecording = true
                //                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
                //                     self?.updateCircularView()
                //                 })
            }
            hearingView()
            
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        audioRecorder = nil
        
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("recording.m4a") {
            do {
                let audioData = try Data(contentsOf: url)
                print(getDirectory().appendingPathComponent("recording.m4a"), "dataaaaaaaaa")
                recognizeSong(path: getDirectory().appendingPathComponent("recording.m4a"))
                
            } catch {
                print("Failed to play recorded audio: \(error.localizedDescription)")
            }
        }
    }
    
    private func hearingView() {
        
        pulsyBtn.setImage(UIImage(named: "Component 1"), for: .normal)
        songImgView.isHidden = false
        self.view.backgroundColor = UIColor(hex: "1E1029", alpha: 1)
        adView.isHidden = true
        searchBar.isHidden = true
        searchBtnOutlet.isHidden = true
        settingBtn.isHidden = true
        instructionsView.isHidden = true
        closeRecognitionBtn.isHidden = false
        hummingResponseLbl.isHidden = false
        assistLabel.isHidden = false
        tabBarController?.tabBar.isHidden = true
        hidePlayer()
        backLbl.isHidden = true
        backBtnOutlet.isHidden = true
        noSongAlertLbl.isHidden = true
        tapLbl.isHidden = true
        pulsyBtn.isEnabled = true
        //        pulsyBtn.layer.removeAllAnimations()
        
        pulsyAnimation()
        print("111...")
    }
    
    //    private func updateCircularView() {
    //        // Calculate the sound wave intensity based on audio level
    //        audioRecorder?.updateMeters()
    //        let normalizedValue = pow(10, (audioRecorder?.averagePower(forChannel: 0) ?? 0) / 20)
    //
    //        // Update the circular view with the sound wave intensity
    //        circularView.updateSoundWave(intensity: normalizedValue)
    //
    //    }
    //
    
    private func noSongView() {
        self.view.backgroundColor = UIColor(hex: "2C1010", alpha: 1)
        pulsyBtn.setImage(UIImage(named: "Frame 10"), for: .normal)
        backBtnOutlet.isHidden = false
        backLbl.isHidden = false
        noSongAlertLbl.isHidden = false
        tapLbl.isHidden = false
        songImgView.isHidden = true
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        pulsyBtn.layer.removeAllAnimations()
        pulsyBtn.isEnabled = true
    }
    
    private func backToOriginal() {
        self.view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        backBtnOutlet.isHidden = true
        backLbl.isHidden = true
        noSongAlertLbl.isHidden = true
        tapLbl.isHidden = true
        adView.isHidden = false
        searchBar.isHidden = false
        searchBtnOutlet.isHidden = false
        settingBtn.isHidden = false
        instructionsView.isHidden = false
        tabBarController?.tabBar.isHidden = false
        showPlayer()
        pulsyBtn.setImage(UIImage(named: "Component 1"), for: .normal)
        pulsyBtn.isEnabled = true
        songImgView.isHidden = false
        pulsyAnimation()
        
    }
    
    private func pulsyAnimation() {
        
        let pulse1 = CASpringAnimation(keyPath: "transform.scale")
        pulse1.duration = 1
        pulse1.fromValue = 1.0
        pulse1.toValue = 1.12
        pulse1.autoreverses = true
        pulse1.repeatCount = 1
        pulse1.initialVelocity = 0.5
        pulse1.damping = 0.8
        
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        
        animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.0
        animation.repeatCount = Float.infinity
        
        pulsyBtn.layer.add(animation, forKey: "pulse")
    }
    
    // MARK:- Private Methods
    private func setupView() {
        tabBarController?.selectedIndex = 0
        self.view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        setupSearchBar()
        setupSettingBtn()
        //        setupPulsy()
    }
    
    private func hidePlayer() {
        let hide = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hidePlayer"), object: hide)
    }
    
    private func showPlayer() {
        let show = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showPlayer"), object: show)
    }
    
    private func setupSettingBtn() {
        
        settingBtn.borderWidth = 1
        settingBtn.borderColor = UIColor(hex: "2b2b2b", alpha: 1)
        settingBtn.layer.cornerRadius = 12
        settingBtn.clipsToBounds = true
        
        
    }
    private func setupPulsy() {
        
        pulsyBtn.setImage(UIImage(named: "Component 1"), for: .normal)
        pulsyBtn.isUserInteractionEnabled = true
        pulsyBtn.isEnabled = true
        
        pulsyAnimation()
    }
    
    
    @IBAction func closeRecogntionBtnPressed(_ sender: UIButton) {
        self.view.backgroundColor = UIColor(hex: "141414", alpha: 1)
        adView.isHidden = false
        searchBar.isHidden = false
        searchBtnOutlet.isHidden = false
        settingBtn.isHidden = false
        instructionsView.isHidden = false
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
        tabBarController?.tabBar.isHidden = false
        showPlayer()
        
    }
    
    @IBAction func settingsBtnClicked(_ sender: UIButton) {
        
        let settings = UIStoryboard(name: "SettingsVC", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        //        settings.modalPresentationStyle = .fullScreen
        //        self.present(settings,animated: false,completion: nil)
        self.navigationController?.pushViewController(settings, animated: true)
        
        
    }
    
    @IBAction func getPremiumTapped(_ sender: UIButton) {
        
        let premiumVC = UIStoryboard(name: "PremiumVC", bundle: nil).instantiateViewController(withIdentifier: "PremiumVC") as! PremiumVC
        premiumVC.modalPresentationStyle = .custom
        self.present(premiumVC, animated: false, completion: nil)
        
        self.setBlurView()
        premiumVC.delegate = self
        
    }
    
    func recognizeSong(path: URL) {
        let apiUrlString = "https://api.audd.io/"
        let apiKey = "5239c12f53949b82c14d2fd822102c01"
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(path, withName: "file", fileName: "recording.m4a", mimeType: "audio/m4a")
            multipartFormData.append(Data("apple_music,lyrics".utf8), withName: "return")
            multipartFormData.append(Data(apiKey.utf8), withName: "api_token")
        }, to: apiUrlString).responseDecodable { (response: AFDataResponse<SongResponse>) in
            switch response.result {
                
            case .success(let data):
                let player = UIStoryboard(name: "PlayerVC", bundle: nil).instantiateViewController(withIdentifier: "PlayerVC") as! PlayerVC
                player.recognitionData = data
                self.navigationController?.pushViewController(player, animated: true)
                print(data, "DAAATaaaaa")
            case .failure(let error):
                self.noSongView()
                print(error, "EErrorr")
            }
        }
    }

    func checkMicrophoneAccess() {
        // Check Microphone Authorization
        switch AVAudioSession.sharedInstance().recordPermission {
            
        case AVAudioSession.RecordPermission.granted:
            print(#function, " Microphone Permission Granted")
            break
            
        case AVAudioSession.RecordPermission.denied:
            // Dismiss Keyboard (on UIView level, without reference to a specific text field)
            UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
            let alert = UIAlertController(title: "Mic Error", message: "Not authorized", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Click", style: .default, handler: { _ in
                DispatchQueue.main.async {
                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                        
                        UIApplication.shared.open(settingsURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                    }
                } // end dispatchQueue
                
            }))
            self.present(alert, animated: true, completion: nil)
            
            
            return
            
        case AVAudioSession.RecordPermission.undetermined:
            print("Request permission here")
            // Dismiss Keyboard (on UIView level, without reference to a specific text field)
            UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
            
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                // Handle granted
                if granted {
                    print(#function, " Now Granted")
                } else {
                    print("Pemission Not Granted")
                    
                } // end else
            })
        @unknown default:
            print("ERROR! Unknown Default. Check!")
        } // end switch
        
    }
    
    func getDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

extension SearchVC: BlurVCDelegate {
    
    func removeBlurView() {
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
}


// Helper function inserted by Swift migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}

// Helper function inserted by Swift migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

extension Data {
    mutating func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
