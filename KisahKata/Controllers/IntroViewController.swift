//
//  IntroViewController.swift
//  KisahKata
//
//  Created by Mulazi Azi on 30/07/21.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var startLearningButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startLearningButton.layer.cornerRadius =  12
        startLearningButton.setTitle("Yuk belajar", for: .normal)
        startLearningButton.backgroundColor = UIColor(named: "PrimaryColor")
        startLearningButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        startLearningButton.semanticContentAttribute = .forceRightToLeft
        startLearningButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        startLearningButton.frame.size.height = 45
        
        nameLabel.font = UIFont(name: "Ubuntu-Regular", size: 18)
        titleLabel.font = UIFont(name: "Ubuntu-Bold", size: 30)
        
        /// call gesture to hide keyboard when user click anywhere
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
    @IBAction func startLearn(_ sender: UIButton) {
        
        self._animateSpringView(sender)
        
        if userNameTextField.text != "" {
            UserDefaults.standard.set(userNameTextField.text, forKey: "username")
            
            print(userNameTextField)
            
            dismiss(animated: true, completion: nil)
            UserDefaults.standard.synchronize()
        }
        
        
    }
    
    // file private function
    fileprivate func _animateSpringView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
    
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)

        }) { (_) in
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: nil)
            
        }
        
    }

}
