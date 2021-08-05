//
//  StoryEndViewController.swift
//  KisahKata
//
//  Created by Mulazi Azi on 31/07/21.
//

import UIKit

class StoryEndViewController: UIViewController {

    @IBOutlet weak var endStoryAcceptButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        endStoryAcceptButton.layer.cornerRadius = 12
    }
    
    @IBAction func didTapGoToHomeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
