//
//  StoryOverviewViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 01/08/21.
//

import UIKit

class StoryOverviewViewController: UIViewController {

    
    @IBOutlet weak var btnTest: UIButton!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        backButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        backButton.layer.shadowOpacity = 1.0
        backButton.layer.shadowRadius = 10.0
        backButton.layer.masksToBounds = false
        
//        btnTest.addBorder(side: 2, color: UIColor.green, width: 2)
    }
    
    @IBAction func playStoryTap(_ sender: Any) {
//        performSegue(withIdentifier: "goToStorytellingStoryboard", sender: self)
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Storytelling", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "StorytellingVC") as! StorytellingViewController
//        self.present(nextViewController, animated:true, completion:nil)
        
        let storyboard = UIStoryboard(name: "Storytelling", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StorytellingVC") as! StorytellingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
