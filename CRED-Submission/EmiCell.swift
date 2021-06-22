//
//  EmiCellCollectionViewCell.swift
//  CRED-Submission
//
//  Created by Darshil Agrawal on 22/06/21.
//

import UIKit

class EmiCell: UICollectionViewCell {

    @IBOutlet weak var selectedCircle: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var bottomCalculationLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    var content: EmiCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = CGFloat(14)
    }
    func loadContent(){
        
        amountLabel.text = "₹" +  (content?.amount.description ?? "") + "/mo"
        durationLabel.text = "for " + (content?.duration.description ?? "") + " months"
        if content?.isSelected ?? false {
            selectedCircle.image = #imageLiteral(resourceName: "circle-withTick")
        }else {
            selectedCircle.image = #imageLiteral(resourceName: "empty-circle")
        }
    }

}
