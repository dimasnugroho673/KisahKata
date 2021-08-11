//
//  PracticeEndViewController.swift
//  KisahKata
//
//  Created by Mulazi Azi on 12/08/21.
//

import UIKit

class PracticeEndViewController: UIViewController {

    @IBOutlet weak var endPracticeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        endPracticeButton.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }
    
    @IBAction func endPracticeButtonTapped(_ sender: Any) {
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
