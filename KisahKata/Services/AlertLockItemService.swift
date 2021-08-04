//
//  AlertLockItemService.swift
//  KisahKata
//
//  Created by Dimas Putro on 04/08/21.
//

import UIKit

class AlertLockItemService {
    
    func alert(title: String, message: String) -> AlertLockItemViewController {
        let storyboard = UIStoryboard(name: "CustomScreen", bundle: .main)
        
        let alertVC = storyboard.instantiateViewController(identifier: "AlertLockItemVC") as! AlertLockItemViewController
        alertVC.titleAlert = title
        alertVC.message = message
        
        return alertVC
    }
}
