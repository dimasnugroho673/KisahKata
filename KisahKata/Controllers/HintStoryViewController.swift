//
//  HintStoryViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 02/08/21.
//

import UIKit

class HintStoryViewController: UIViewController {

    @IBOutlet weak var hintContainerView: UIView!
    @IBOutlet weak var closeHintButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hintContainerView.layer.cornerRadius = 32
        closeHintButton.layer.cornerRadius = 12
    }
    
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
