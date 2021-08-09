//
//  homeCollectionViewCell.swift
//  KisahKata
//
//  Created by Farendza Muda on 01/08/21.
//

import UIKit

class homeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var temaImage: UIImageView!
    @IBOutlet weak var temaLabel: UILabel!
    @IBOutlet weak var cntnView: UIView!
    
    @IBOutlet weak var lockImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //self.layer.cornerRadius = 25
        DispatchQueue.main.async {
            self.cntnView.layer.cornerRadius = 12.0
            self.cntnView.layer.shadowColor = UIColor.gray.cgColor
//            self.cntnView.layer.shadowOpacity = 0.5
//            self.cntnView.layer.shadowOpacity = 10.0
            self.cntnView.layer.shadowOffset = .zero
            self.cntnView.layer.shadowPath = UIBezierPath(rect: self.cntnView.bounds).cgPath
            //self.cntnView.layer.shouldRasterize = true
            self.temaImage.roundCorners(corners: [.topLeft, .topRight], radius: 12)
//            self.temaImage.roundCorners(corners: .topRight, radius: 12)
            
            
            
        }
        
        
    }
    
    func setDataIntoCell(tema: TemaCerita) {
        self.temaLabel.text = tema.title
        
    }
    
    

}


extension UIView
{
  func roundCorners(corners:UIRectCorner, radius: CGFloat)
  {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
