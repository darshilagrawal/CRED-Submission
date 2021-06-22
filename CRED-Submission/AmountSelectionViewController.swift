//
//  AmountSelectionViewController.swift
//  CRED-Submission
//
//  Created by Darshil Agrawal on 22/06/21.
//

import UIKit
import HGCircularSlider
class AmountSelectionViewController: UIViewController,UIGestureRecognizerDelegate {
    var state: Bool = false
    @IBOutlet weak var AmountTitleLabel: UILabel!
    
    @IBOutlet weak var AmountSecondaryLabel: UILabel!
    
    @IBOutlet weak var finalPriceLabel: UILabel!
    
    @IBOutlet weak var CircularCardView: UIView!
    
    @IBOutlet weak var mainCircularView: CircularSlider!
    
    @IBOutlet weak var proceedToEmiButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var amountScreenMainLabel: UILabel!
    
    @IBOutlet weak var amountScreenSecondaryLabel: UILabel!
    
    var nameOfPerson:String = ""
    var finalValueInString:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpCircularView()
        // Do any additional setup after loading the view.
    }
    func setUpViews(){
        proceedToEmiButton?.layer.cornerRadius = CGFloat(14)
        proceedToEmiButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView?.layer.cornerRadius = CGFloat(14)
        contentView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        CircularCardView?.layer.cornerRadius = CGFloat(14)
        amountScreenMainLabel.text = "\(nameOfPerson), how much do you need?"
        AmountSecondaryLabel.text = "move the dial and set any amount you need upto ₹ 487,891"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTouchAction))
        tapGesture.delegate = self
        self.view?.addGestureRecognizer(tapGesture)
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backgroundTouchAction))
        swipeGesture.direction = .left
        self.view?.addGestureRecognizer(swipeGesture)
        
    }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if contentView?.frame.contains(touch.location(in: view)) ?? false {
            return false
        }
        return true
    }
    
    @objc func backgroundTouchAction() {
        self.state = false
        navigationController?.popViewController(animated: true)
    }
    
    
    func setUpCircularView(){
        mainCircularView.minimumValue = 0
        mainCircularView.maximumValue = 487891
        mainCircularView.addTarget(self, action: #selector(sliderMoved), for: .valueChanged)
    }
    
    @objc func sliderMoved(){
        let finalValue = mainCircularView.endPointValue
        finalValueInString = String(format: "%.0f", finalValue)
        finalPriceLabel.text = finalValueInString
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.state = false
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func proceedToEmiButtonTapped(_ sender: UIButton) {
        let finalVC = EmiSelectionViewController(nibName: "EmiSelectionViewController", bundle: nil)
        let selectedAmount = mainCircularView.endPointValue.rounded()
        
        let emi1 = EmiCellModel(duration: 12, amount: Int(selectedAmount)/12)
        let emi2 = EmiCellModel(duration: 9, amount: Int(selectedAmount)/9)
        let emi3 = EmiCellModel(duration: 6, amount: Int(selectedAmount)/6)
        finalVC.cells = [emi1,emi2,emi3]
        finalVC.state = true
        finalVC.modalPresentationStyle = .overCurrentContext
        finalVC.backToView = {[weak self] in
            self?.setUpViews()
        }
        self.present(finalVC, animated: true){
            self.amountScreenMainLabel.text = "Credit Amount"
            self.AmountSecondaryLabel.text = "₹ "+self.finalValueInString
        }
        
    }
    
    
}
