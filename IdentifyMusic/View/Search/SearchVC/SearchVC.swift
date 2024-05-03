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
import YouTubeKit
import GoogleAPIClientForREST

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
   // var recordedAudio: AVAudioPlayer?
    
    let service = GTLRYouTubeService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
   
        checkMicrophoneAccess()
        closeRecognitionBtn.isHidden = true
        hummingResponseLbl.isHidden = true
        assistLabel.isHidden = true
   
        backBtnOutlet.isHidden = true
        backLbl.isHidden = true
        noSongAlertLbl.isHidden = true
        tapLbl.isHidden = true
//        setupAudioRecorder()
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
        setupView()
        
 
    }
    
    func searchForMusic(query: String) {
        let query = GTLRYouTubeQuery_SearchList.query(withPart: ["snippet"])
        query.q = query
        query.maxResults = 10
        
        service.apiKey = "YOUR_API_KEY"
        
        service.executeQuery(query) { (ticket, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let searchResponse = response as? GTLRYouTube_SearchListResponse {
                for item in searchResponse.items! {
                    if let searchResult = item as? GTLRYouTube_SearchResult {
                        if let snippet = searchResult.snippet {
                            print("Title: \(snippet.title)")
                            print("Description: \(snippet.descriptionProperty)")
                            print("Thumbnail: \(snippet.thumbnails!.defaultProperty!.url!)")
                        }
                    }
                }
            }
        }
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
            }
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
               // recordedAudio = try AVAudioPlayer(data: audioData)
               // recordedAudio?.play()
            } catch {
                print("Failed to play recorded audio: \(error.localizedDescription)")
            }
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
    
    private func hearingView() {
        
    
//        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.update), userInfo: nil, repeats: false)
//    
      
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
        pulsyBtn.isEnabled = false
        pulsyAnimation()
        print("111...")
    }
    
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
    
    @objc func addButtonTapped() {
        
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
        settings.modalPresentationStyle = .fullScreen
        self.present(settings,animated: false,completion: nil)
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
        }, to: apiUrlString).responseJSON { response in
            switch response.result {
                
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func createBodyWithParameters(parameters: [String: String], filePathKey: String?, audioData: Data?, boundary: String) -> Data {
        var body = Data();

        for (key, value) in parameters {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }

        let filename = "recording.m4a"
        let mimetype = "audio/m4a"

        body.appendString("--\(boundary)\r\n")

        if let filePath = filePathKey {
            let imageData = self.getDirectory().appendingPathComponent("recording.m4a")
            body.appendString("Content-Disposition: form-data; name=\"\(filePath)\"; filename=\"\(filename)\"\r\n")
            body.appendString("Content-Type: \(mimetype)\r\n\r\n")
            body.appendString("\(imageData)")
            body.appendString("\r\n")
            body.appendString("--\(boundary)--\r\n")
        }

        return body
    }
    
    func handleRecognitionResponse(_ response: [String: Any]) {
        // Process the recognition response here
        // You can extract the recognized song information from the response dictionary
        // For example, you can access the "title", "artist", or "album" fields

        if let title = response["title"] as? String {
            print("Title: \(title)")
        }

        if let artist = response["artist"] as? String {
            print("Artist: \(artist)")
        }

        if let album = response["album"] as? String {
            print("Album: \(album)")
        }
        
        print(response, "Response")

        // Continue with further processing or UI updates based on the recognition results
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
    
    // completion of recording
//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if flag {
//            
//            soundsRecordPlayStatusLabel.text = "Recording Completed"
//            
//            recordButtonOutlet.setImage(UIImage(named: "Microphone-Jolly"), for: UIControl.State())
//            playButtonOutlet.setImage(UIImage(named: "Play-Jolly"), for: UIControl.State())
//            stopButtonOutlet.setImage(UIImage(named: "Stop-Outlined"), for: UIControl.State())
//            
//            recordButtonOutlet.isEnabled = true
//            playButtonOutlet.isEnabled = true
//            stopButtonOutlet.isEnabled = false
//            
//        }
//    }
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
