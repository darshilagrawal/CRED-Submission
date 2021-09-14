//
//  BankSelectionViewController.swift
//  CRED-Submission
//
//  Created by Darshil Agrawal on 22/06/21.
//

import UIKit

class BankSelectionViewController: UIViewController,UIGestureRecognizerDelegate {
    var state: Bool = false
    @IBOutlet weak var changeAccountButton: UIButton!
    
    @IBOutlet weak var paytmImageLogo: UIImageView!
    
    @IBOutlet weak var selectionButton: UIButton!
    
    @IBOutlet weak var bankBottomButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    var paytmSelected: Bool = false
    var backToView: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeAccountButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "This Screen is Ready", message: StringConstants.roadmap, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Didn't See that coming", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Good Job", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func finalBackButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "That's It For The Day", message: StringConstants.thanks, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "You are Hired", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "You are Definetely Hired :)", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func setUpViews(){
        self.bankBottomButton?.layer.cornerRadius = CGFloat(14)
        self.bankBottomButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.contentView?.layer.cornerRadius = CGFloat(14)
        self.contentView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.paytmImageLogo.layer.cornerRadius = 12
        self.paytmImageLogo.clipsToBounds = true
        selectionButton.layer.cornerRadius = 12
        selectionButton.clipsToBounds = true
        self.changeAccountButton?.layer.borderWidth = CGFloat(1.0)
        self.changeAccountButton?.layer.borderColor = UIColor.white.cgColor
        self.changeAccountButton?.layer.cornerRadius = CGFloat(12)
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
        backToView()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.state = false
        backToView()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectionButtonPressed(_ sender: UIButton) {
        self.paytmSelected = !self.paytmSelected
        if paytmSelected{
            selectionButton.setImage(#imageLiteral(resourceName: "circle-withTick"), for: .normal)
        }else{
            selectionButton.setImage(#imageLiteral(resourceName: "empty-circle"), for: .normal)
        }
    }
    

}
