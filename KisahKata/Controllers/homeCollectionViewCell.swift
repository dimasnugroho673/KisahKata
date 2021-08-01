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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async {
            self.cntnView.layer.cornerRadius = 12.0
            self.cntnView.layer.shadowColor = UIColor.gray.cgColor
            self.cntnView.layer.shadowOpacity = 0.5
            self.cntnView.layer.shadowOpacity = 10.0
            self.cntnView.layer.shadowOffset = .zero
            self.cntnView.layer.shadowPath = UIBezierPath(rect: self.cntnView.bounds).cgPath
            self.cntnView.layer.shouldRasterize = true
        }
    }

}
