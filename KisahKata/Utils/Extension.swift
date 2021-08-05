//
//  Extension.swift
//  KisahKata
//
//  Created by Dimas Putro on 31/07/21.
//

import UIKit
import AVFoundation

extension String {

    // filter string
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
}


extension UIImage {
    
    // untuk rounded uiimage custom
//    var roundedImage: UIImage {
//        let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: self.size)
//        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
//        UIBezierPath(
//            roundedRect: rect,
//            cornerRadius: 102
//            ).addClip()
//        self.draw(in: rect)
//        return UIGraphicsGetImageFromCurrentImageContext()!
//    }
}


extension UIView {
    
    // untuk rounded uiview custom
    // default value rounded 24
    func roundedBorder(cornerRadius: Int = 24) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight, .topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath.cgPath
        layer.mask = maskLayer1
    }
}


extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

//MARK - Fonts Constants
struct Fonts {
    
    static func italicFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-Italic", size: size)!
    }
    
    static func lightFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-Light", size: size)!
    }
    
    static func lightItalicFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-LightItalic", size: size)!
    }
    
    static func regularFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-Regular", size: size)!
    }
    
    static func mediumFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-Medium", size: size)!
    }
    
    static func mediumItalicFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-MediumItalic", size: size)!
    }
    
    static func boldFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-Bold", size: size)!
    }
    
    static func boldItalicFontWithSize(size: CGFloat) -> UIFont {
        return UIFont(name:"Ubuntu-BoldItalic", size: size)!
    }
    
}

struct Colors {
    
    static let carmine = UIColor.init(red: 169.0/255.0, green: 1.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    
    static let greyColor = UIColor.init(red: 108.0/255.0, green: 108.0/255.0, blue: 108.0/255.0, alpha: 1.0)
}


// Hide keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
