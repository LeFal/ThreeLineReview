//
//  MakeReviewTargetViewController.swift
//  ThreeLineReview
//
//  Created by LEOFALCON on 2017. 6. 25..
//  Copyright © 2017년 LeFal. All rights reserved.
//

import UIKit

class MakeReviewTargetViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource  {

    @IBOutlet var pickCategory: UIPickerView!
    @IBOutlet var writeDefaultInfo: UITextView!
    @IBOutlet var writeScore: UITextField!
    @IBOutlet var writeReview: UITextView!
    
    var pickerData: [String] = ["1","2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickCategory.delegate = self
        self.pickCategory.dataSource = self
        
        writeDefaultInfo.layer.borderColor = UIColor.black.cgColor
        writeDefaultInfo.layer.borderWidth = 1
        writeReview.layer.borderColor = UIColor.black.cgColor
        writeReview.layer.borderWidth = 1
        
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    

}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
