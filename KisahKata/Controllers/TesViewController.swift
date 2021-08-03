//
//  TesViewController.swift
//  KisahKata
//
//  Created by Mulazi Azi on 02/08/21.
//

import UIKit

class TesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func TesButton(_ sender: Any) {
        
//        let storyboard = UIStoryboard(name: "UserIntro", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "IntroVC") as! IntroViewController
//        controller.modalPresentationStyle = .fullScreen
//        controller.modalTransitionStyle = .coverVertical
//        present(controller, animated: true, completion: nil)
        self.performSegue(withIdentifier: "Tes", sender: nil)
    }
    
}
