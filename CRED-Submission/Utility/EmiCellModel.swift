//
//  EmiCellModel.swift
//  CRED-Submission
//
//  Created by Darshil Agrawal on 22/06/21.
//

import Foundation
import UIKit

class EmiCellModel{
    init(duration:Int,amount:Int) {
        self.duration = duration
        self.amount = amount
    }
    
    var duration: Int
    var amount: Int
    var isSelected: Bool = false
    
}
