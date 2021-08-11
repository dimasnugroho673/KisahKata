//
//  JudulCollectionViewCell.swift
//  KisahKata
//
//  Created by Farendza Muda on 03/08/21.
//

import UIKit

class JudulCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cntnView: UIView!
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var scoreImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.cntnView.layer.cornerRadius = 13
    }
    
    func setDataIntoCell(ceritas: Cerita) {
        self.judulLabel.text = ceritas.title
        
    }

}
