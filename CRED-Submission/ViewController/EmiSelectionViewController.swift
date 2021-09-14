//
//  EmiSelectionViewController.swift
//  CRED-Submission
//
//  Created by Darshil Agrawal on 22/06/21.
//

import UIKit

class EmiSelectionViewController: UIViewController,UIGestureRecognizerDelegate {
    var state: Bool = false
    @IBOutlet weak var EmiTopLabel: UILabel!
    @IBOutlet weak var EmiBottomLabel: UILabel!
    @IBOutlet weak var EmiOptionsCollection: UICollectionView!
    @IBOutlet weak var chooseYourPlanButton: UIButton!
    @IBOutlet weak var EmiBottomButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    
    var cells: [EmiCellModel] = []
    var cellSelected: Int = 0
    var backToView: () -> Void = {}
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        cells[0].isSelected = true
        EmiOptionsCollection.delegate = self
        EmiOptionsCollection.dataSource = self
        let nib = UINib(nibName: "EmiCell", bundle: nil)
        EmiOptionsCollection.register(nib, forCellWithReuseIdentifier: "EmiCell")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createYourPlanTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "This Screen is Ready", message: StringConstants.roadmap, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Didn't See that coming", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Good Job", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
     func setUpViews(){
        EmiBottomButton?.layer.cornerRadius = CGFloat(14)
        EmiBottomButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView?.layer.cornerRadius = CGFloat(14)
        contentView?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        EmiOptionsCollection.backgroundColor = .clear
        chooseYourPlanButton?.layer.borderWidth = CGFloat(1.0)
        chooseYourPlanButton?.layer.borderColor = UIColor.white.cgColor
        chooseYourPlanButton?.layer.cornerRadius = CGFloat(12)
        EmiTopLabel.text = StringConstants.repay
        EmiBottomLabel.text = StringConstants.choose
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
    

    @IBAction func bottomButtonPressed(_ sender: UIButton) {
       let finalVC = BankSelectionViewController(nibName: "BankSelectionViewController", bundle: nil)
        finalVC.modalPresentationStyle = .overCurrentContext
        finalVC.backToView = {[weak self] in
            self?.setUpViews()
        }
        finalVC.state = true
        self.present(finalVC, animated: true){
            self.EmiTopLabel.text = "₹ " + self.cells[self.cellSelected].amount.description
            self.EmiBottomLabel.text = self.cells[self.cellSelected].duration.description + " months"
        }
    }
    
}


extension EmiSelectionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmiCell", for: indexPath) as? EmiCell else{
            fatalError("Unable to load cell")
        }
        cell.content = cells[indexPath.row]
        cell.loadContent()
        cell.backgroundColor = UIColor(named: CollectionCellColors.colors[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row != cellSelected {
            cells[cellSelected].isSelected = false
            cellSelected = indexPath.row
            cells[indexPath.row].isSelected = true
            DispatchQueue.main.async {
                self.EmiOptionsCollection.reloadData()
            }
        }
    }
    
    
}
