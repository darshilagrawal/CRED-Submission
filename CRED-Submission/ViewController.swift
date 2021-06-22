//
//  ViewController.swift
//  CRED-Submission
//
//  Created by Darshil Agrawal on 22/06/21.
//

import UIKit
import Synth

class ViewController: UIViewController {
    var state: Bool = true
    @IBOutlet weak var mainHeading: UILabel!
    
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
            let alert = UIAlertController(title: "It's Important", message: "We at Cred believe in anonymity but your name is Important :)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "I Understand", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Good Job", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

