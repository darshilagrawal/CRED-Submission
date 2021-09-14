//
//  ViewController.swift
//  CRED-Submission
//
//  Created by Darshil Agrawal on 22/06/21.
//

import UIKit
import Synth
import Lottie

class ViewController: UIViewController {
    var state: Bool = true
    @IBOutlet weak var mainHeading: UILabel!
    
    @IBOutlet weak var creditCardAnimation: AnimationView!
    @IBOutlet weak var subHeading: UILabel!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        mainHeading.text = "Welcome to CRED"
        mainHeading.applyNeuStyle(model: NeuUIHelper.getDebossModel(), showOnlyShadows: true)
        subHeading.applyNeuStyle(model: NeuUIHelper.getDebossModel(), showOnlyShadows: true)
//        creditCardAnimation.animation = Animation.named("33021-credit-card-swipe")
        creditCardAnimation.animationSpeed = 0.8
        creditCardAnimation.loopMode = .loop
//        creditCardAnimation.contentMode = .scaleAspectFill
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        creditCardAnimation.play()

    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        if nameField.text != ""{
            if let nameToPass = nameField.text{
            let vc = AmountSelectionViewController(nibName: "AmountSelectionViewController", bundle: nil)
            vc.nameOfPerson = nameToPass
            vc.state = true
                self.state = false
        self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let alert = UIAlertController(title: "It's Important", message: StringConstants.policy, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "I Understand", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Good Job", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

