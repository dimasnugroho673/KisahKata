//
//  LockItemViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 04/08/21.
//

import UIKit

class AlertLockItemViewController: UIViewController {

    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var closeAlertButton: UIButton!
    @IBOutlet weak var alertContainerView: UIView!
    
    var titleAlert: String?
    var message: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertContainerView.layer.cornerRadius = 32
        closeAlertButton.layer.cornerRadius = 12
        
        alertTitleLabel.text = titleAlert
        messageLabel.text = message
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
