//
//  AlertExitService.swift
//  KisahKata
//
//  Created by Dimas Putro on 02/08/21.
//

import UIKit

class AlertExitService {
    
    func alert(completion: @escaping () -> Void) -> AlertExitViewController {
        let storyboard = UIStoryboard(name: "CustomScreen", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(identifier: "AlertExitVC") as! AlertExitViewController
        alertVC.buttonAction = completion
        
        return alertVC
    }
}
