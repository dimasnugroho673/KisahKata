//
//  StorytellingViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 01/08/21.
//

import UIKit
import AVFoundation
import CoreData

class StorytellingViewController: UIViewController {

    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scriptContainerView: UIView!
    @IBOutlet weak var scriptStoryLabel: UILabel!
    
    let story: [String] = ["*Selamat pagi*, semuanya.", "Saya ingin *memperkenalkan*, nama saya M-Eggy.", "Tapi kalian bisa *panggil* saya Megi.", "Saya anak kedua dari tiga *bersaudara*.", "Umur saya 9 tahun. Saya lahir di Batam, 23 Februari 2012."]
    let highlightedWords = ["Selamat pagi", "memperkenalkan", "panggil", "bersaudara"]
    let storyIlustrations: [String] = ["Story1", "Story2", "Story3", "Story4", "Story5"]
    let storyInArray: [String] = []
    var activePart: Int = 0
    var wordTemp: String = ""
    var wordClicked: Set<String> = []
    let isFirstLearning: Bool = false
    
    
    @IBOutlet var hintBgBlurView: UIVisualEffectView!
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var titleHintLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var closeHintButton: UIButton!
    @IBOutlet weak var storyProgressBar: UIProgressView!
    @IBOutlet weak var ilustrationStoryImage: UIImageView!
    @IBOutlet weak var openPetunjukButton: UIButton!
    
    var playerLayer = AVPlayerLayer()
    let playVideoButton = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 60))
    
    var kosakatas = [Kosakata]()
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext

        // Do any additional setup after loading the view.
        previousButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        previousButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        previousButton.layer.shadowOpacity = 1.0
        previousButton.layer.shadowRadius = 10.0
        previousButton.layer.masksToBounds = false
        
        nextButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        nextButton.layer.shadowOpacity = 1.0
        nextButton.layer.shadowRadius = 10.0
        nextButton.layer.masksToBounds = false
        
        scriptContainerView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        scriptContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        scriptContainerView.layer.shadowOpacity = 1.0
        scriptContainerView.layer.shadowRadius = 10.0
        scriptContainerView.layer.masksToBounds = false
        scriptContainerView.layer.backgroundColor = UIColor(named: "PrimaryMutedColor")?.cgColor
        scriptContainerView.layer.cornerRadius = 12
//        scriptContainerView.roundedBorder(cornerRadius: 12)
        scriptContainerView.layer.borderWidth = 2
        scriptContainerView.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor

        /// show hint belajar
        let valueFirstLearning = UserDefaults.standard.bool(forKey: "isFirstLearning")
        
        if valueFirstLearning == false {
            let alert = HintStoryService()
            let alertVC = alert.alert()
            present(alertVC, animated: true)
            
            UserDefaults.standard.set(true, forKey: "isFirstLearning")
        }
        
        /// set blur width to bounds
        hintBgBlurView.bounds = self.view.bounds
        hintBgBlurView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        videoContainerView.roundedBorder(cornerRadius: 12)
        
        closeHintButton.layer.cornerRadius = 12
        
        /// setup label click
        _generateContent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func petunjukButton(_ sender: Any) {
        let alert = HintStoryService()
        let alertVC = alert.alert()
            
        present(alertVC, animated: true)
        
    }
    
    
    
    @IBAction func backTap(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        
        let alert = AlertExitService()
        
        let alertVC = alert.alert() { [weak self] in
            print("seharusnya exit berlajar")
            self!.dismiss(animated: true, completion: nil)
        }
        
        present(alertVC, animated: true)
    }
    
    @IBAction func nextPartTap(_ sender: Any) {
        if self.activePart < story.count - 1 {
            self.activePart += 1
            _generateContent()
            
//            self._animateSpringView(sender)
        } else if self.activePart == story.count - 1 {
            _generateContent()
            nextButton.setImage(UIImage(named: "ic_complete"), for: .normal)
            
            /// cerita selesai
//            self._animateSpringView(sender)
            performSegue(withIdentifier: "goToEndStory", sender: nil)
        }

        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        
    }
    
    @IBAction func prevPartTap(_ sender: Any) {
        
        if self.activePart == 0 {
            
            self.activePart = 0
            _generateContent()
            
        } else if self.activePart <= story.count - 1 {
            
            self.activePart -= 1
            _generateContent()
            
        }
        
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    
    
    
    
    //MARK:- Setup all components
    private func _generateContent() {
        _fetchIlustration()
        _fetchProgressBar()
        _fetchScriptStory()
        _fetchButton()
    }
    
    private func _fetchIlustration() {
        /// change image with transition
        _transitionImage(desiredView: ilustrationStoryImage)
        ilustrationStoryImage.animationRepeatCount = 1
        ilustrationStoryImage.contentMode = .scaleAspectFill
        
    }
    
    private func _fetchProgressBar() {
        storyProgressBar.progress = Float(Float(activePart) / Float(story.count - 1))
        
        if Float(Float(activePart) / Float(story.count - 1)) == 1.0 {
            storyProgressBar.progressTintColor = UIColor(named: "SuccessColor")
        } else {
            if Float(Float(activePart) / Float(story.count - 1)) == 0.0 {
                storyProgressBar.progress = Float(Float(activePart + 1) / Float(story.count - 1))
            } else {
                storyProgressBar.progress = Float(Float(activePart) / Float(story.count - 1))
                storyProgressBar.progressTintColor = UIColor(named: "SecondaryColor")
            }
        }
    }
    
    private func _fetchButton() {
        if self.activePart == 0 {
            UIView.transition(with: previousButton, duration: 0.75, options: .transitionCrossDissolve, animations: {
                self.previousButton.isHidden = true
            }, completion: nil)
        } else {
            UIView.transition(with: previousButton, duration: 0.75, options: .transitionCrossDissolve, animations: {
                self.previousButton.isHidden = false
            }, completion: nil)
            if self.activePart == story.count - 1 {
                /// cerita selesai
                UIView.transition(with: nextButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.nextButton.setImage(UIImage(named: "ic_complete"), for: .normal)
                }, completion: nil)
            } else {
                UIView.transition(with: nextButton, duration: 0.5, options: .transitionCrossDissolve, animations: {
                    self.nextButton.setImage(UIImage(named: "ic_next"), for: .normal)
                }, completion: nil)
            }
            
        }
    }
    
    
    //MARK:- Open Hint Sign Language
    private func _openHintWord(wordTap: String) {
        // set haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        _animateIn(desiredView: hintBgBlurView)
        
        titleHintLabel.text = wordTap
        _fetchVideo(word: wordTap)
        _fetchDescription(word: wordTap)
    }
    
    private func _fetchDescription(word: String) {
        
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()
        kosakataRequest.predicate = NSPredicate(format: "kata = %@", word)
        kosakataRequest.returnsObjectsAsFaults = false
        
        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
        
            descriptionTextView.text = kosakatas[0].deskripsi!
        } catch {
            print("Gagal load data deskrpsi!")
        }
       
    }
    
    
    @IBAction func didTapCloseHintButton(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        playVideoButton.isHidden = true
        _animateOut(desiredView: hintBgBlurView)
    }
    
    private func _fetchVideo(word: String) {
        
        playVideoButton.isHidden = true
        
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()
        kosakataRequest.predicate = NSPredicate(format: "kata = %@", word)
        kosakataRequest.returnsObjectsAsFaults = false
        
        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
            
            /// video online
//            let videoURL = URL(string: kosakatas[0].urlVideo!)!
            
            /// kalo videonya offline
            let file = kosakatas[0].urlVideo!.components(separatedBy: ".")
            
            guard let filePath = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
                  debugPrint( "\(file.joined(separator: ".")) not found")
                  return
            }
            
            /// video offline
            let videoURL = URL(fileURLWithPath: filePath)
            
            let player = AVPlayer(url: videoURL)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
            playerLayer.frame.size.width = videoContainerView.bounds.width
            playerLayer.frame.size.height = videoContainerView.bounds.height
            playerLayer.videoGravity = .resizeAspectFill
            
            playVideoButton.setImage(UIImage(named: "ic_play_dark"), for: .normal)
            playVideoButton.tintColor = UIColor.white
            playVideoButton.layer.frame = CGRect(x: videoContainerView.frame.width / 2 - 30, y: videoContainerView.frame.height / 2 - 30, width: 60, height: 60)
            playVideoButton.addTarget(self,
                                action: #selector(didTapPlayVideoButton),
                                for: .touchUpInside)
            playVideoButton.contentHorizontalAlignment = .fill
            playVideoButton.contentVerticalAlignment = .fill
            
            videoContainerView.roundedBorder(cornerRadius: 12)
            videoContainerView.layer.addSublayer(playerLayer)
            videoContainerView.addSubview(playVideoButton)

            NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name:
            NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
            
            player.isMuted = true
            player.play()
        } catch {
            print("Gagal load data video!")
        }

        
    }
    
    
    //MARK:- Play Video Button did Tap
    @objc
    func didTapPlayVideoButton() {
        _fetchVideo(word: wordTemp)
    }

    
    //MARK:- OBSERVER
    @objc func videoDidEnd(notification: NSNotification) {
        playVideoButton.isHidden = false
    }
    
    //MARK:- fadeeIn
    private func _transitionImage(desiredView: UIView) {
        
        UIView.transition(with: self.ilustrationStoryImage, duration: 0.75, options: .transitionCrossDissolve, animations: {
            self.ilustrationStoryImage.image = UIImage.gifImageWithName(self.storyIlustrations[self.activePart])
        }, completion: nil)
    }
    
    //MARK:- fadeOut
    private func _fadeOut(desiredView: UIView) {
        desiredView.alpha = 1
        
        UIView.animate(withDuration: 0.8, animations: {
            desiredView.alpha = 0
        })
    }
    
    
    //MARK:- AnimateIn
    private func _animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        
        // attach our desired view to the screen
        backgroundView.addSubview(desiredView)
        
        // set view to scalling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
           
        })
    }
    
    //MARK:- AnimateIn
    private func _animateOut(desiredView: UIView) {
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: {_ in
            desiredView.removeFromSuperview()
        })
    }
    
    
    //MARK:- setupTapLabel
    func _fetchScriptStory() {
        var textArray = [String]()
        var fontArray = [UIFont]()
        var colorArray = [UIColor]()
        textArray.append(contentsOf: story[activePart].components(separatedBy: "*"))
        
        for _ in textArray {
            fontArray.append(Fonts.mediumFontWithSize(size: 17.0))
            colorArray.append(Colors.greyColor)
        }
        
        for h in highlightedWords {
            if let i = textArray.firstIndex(of: h) {
                fontArray[i] = Fonts.boldFontWithSize(size: 17.0)
                colorArray[i] = Colors.carmine
            }
        }
        
        self.scriptStoryLabel.attributedText = getAttributedString(arrayText: textArray, arrayColors: colorArray, arrayFonts: fontArray)
        self.scriptStoryLabel.isUserInteractionEnabled = true
        
        let tapLabelGesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_:)))
        tapLabelGesture.numberOfTapsRequired = 1
        self.scriptStoryLabel.addGestureRecognizer(tapLabelGesture)
    }
    
    
    //MARK:- tappedOnLabel
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.scriptStoryLabel.text else { return }
        
        
        for word in highlightedWords {
            if gesture.didTapAttributedTextInLabel(label: self.scriptStoryLabel, inRange: (text as NSString).range(of: "\(word)")) {
                print("user tapped on \(word)")
    
                _openHintWord(wordTap: word)
    
            }
        }
    }


    //MARK:- getAttributedString
    func getAttributedString(arrayText:[String]?, arrayColors:[UIColor]?, arrayFonts:[UIFont]?) -> NSMutableAttributedString {
        
        let finalAttributedString = NSMutableAttributedString()
        
        for i in 0 ..< (arrayText?.count)! {
            
            let attributes = [NSAttributedString.Key.foregroundColor: arrayColors?[i], NSAttributedString.Key.font: arrayFonts?[i]]
            let attributedStr = (NSAttributedString.init(string: arrayText?[i] ?? "", attributes: attributes as [NSAttributedString.Key : Any]))
            
            if i != 0 {
                finalAttributedString.append(NSAttributedString.init(string: ""))
            }
            
            finalAttributedString.append(attributedStr)
        }
        
        return finalAttributedString
    }

}
