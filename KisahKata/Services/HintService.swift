//
//  HintServices.swift
//  KisahKata
//
//  Created by Dimas Putro on 02/08/21.
//

import UIKit

class HintStoryService {
    
    func alert() -> HintStoryViewController {
        let storyboard = UIStoryboard(name: "CustomScreen", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(identifier: "HintStoryVC") as! HintStoryViewController
        
        return alertVC
    }
}
