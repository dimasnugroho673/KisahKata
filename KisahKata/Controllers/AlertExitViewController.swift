//
//  AlertExitViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 02/08/21.
//

import UIKit

class AlertExitViewController: UIViewController {

    @IBOutlet weak var alertContainerView: UIView!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var leaveButton: UIButton!
    
    var buttonAction: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        alertContainerView.layer.cornerRadius = 32
        resumeButton.roundedBorder(cornerRadius: 12)
        
        leaveButton.backgroundColor = .clear
        leaveButton.layer.cornerRadius = 12
        leaveButton.layer.borderWidth = 1
        leaveButton.layer.borderColor = UIColor(named: "MutedColor")?.cgColor
        leaveButton.tintColor = UIColor(named: "TextMutedColor")
    }
    
    @IBAction func didTapLeave(_ sender: Any) {
        
        dismiss(animated: true)
        
        buttonAction?()
    }
    
    @IBAction func didTapResume(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
